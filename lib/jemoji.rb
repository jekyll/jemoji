require 'jekyll'
require 'gemoji'
require 'html/pipeline'

module Jekyll
  class Jemoji < Jekyll::Generator

    safe true

    def src
      @src ||=
        if @site.config.key?("emoji") && @site.config["emoji"].key?("src")
          @site.config["emoji"]["src"]
        else
          "https://assets.github.com/images/icons/"
        end
    end

    def generate(site)
      @site = site
      @filter = HTML::Pipeline::EmojiFilter.new(nil, { :asset_root => src })
      site.pages.each { |page| emojify page }
      site.posts.each { |page| emojify page }
    end

    def emojify(page)
      page.content = @filter.emoji_image_filter(page.content)
    end
  end
end
