require 'jekyll'
require 'gemoji'

module Jekyll
  class Jemoji < Jekyll::Generator
    def src
      @src ||=
        if @site.config.key?("emoji") && @site.config["emoji"].key?("src")
          @site.config["emoji"]["src"]
        else
          "https://github.global.ssl.fastly.net/images/icons/emoji"
        end
    end

    def emoji
      @emoji ||= Emoji.names
    end

    def regex
      @regex ||=
        begin
          emoji_escaped = emoji.map { |emoji| Regexp.escape(emoji) }
          Regexp.new ":(#{emoji_escaped.join("|")}):"
        end
    end

    def generate(site)
      @site = site
      site.pages.each { |page| emojify page }
      site.posts.each { |page| emojify page }
    end

    def emojify(page)
      page.content.gsub!(regex) { img($1) }
    end

    def img(name)
      "<img src=\"#{src}/#{name}.png\" alt=\"#{name}\" class=\"emoji\" height=\"20\" />"
    end
  end
end
