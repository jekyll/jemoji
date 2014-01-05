require 'jekyll'
require 'gemoji'

module Jekyll
  class Jemoji < Jekyll::Generator
    def src
      if @site.config.key?("emoji") && @site.config["emoji"].key?("src")
        @site.config["emoji"]["src"]
      else
        "https://github.global.ssl.fastly.net/images/icons/emoji/"
      end
    end

    def emoji
      Emoji.names
    end

    def regex
      emoji_escaped = emoji.map { |emoji| Regexp.escape(emoji) }
      Regexp.new ":(#{emoji_escaped.join("|")}):"
    end

    def generate(site)
      @site = site
      site.pages.each { |page| emojify page }
      site.posts.each { |page| emojify page }
    end

    def emojify(page)
      page.content.gsub!(regex) { |name| img(name) }
    end

    def img(name)
      "<img src=\"#{src}/#{name}.png\" alt=\"#{name}\" class=\"emoji\" \>"
    end
  end
end
