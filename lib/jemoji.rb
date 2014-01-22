require 'jekyll'
require 'gemoji'
require 'html/pipeline'

module Jekyll
  class Jemoji < Jekyll::Generator

    safe true

    TAG = "jekyll_jemoji"

    def src
      @src ||=
        if @site.config.key?("emoji") && @site.config["emoji"].key?("src")
          @site.config["emoji"]["src"]
        else
          "http://assets.github.com/images/icons/"
        end
    end

    def generate(site)
      @site = site
      site.pages.each { |page| emojify page }
      site.posts.each { |page| emojify page }
    end

    def emojify(page)
      filter = HTML::Pipeline::EmojiFilter.new(
        "<#{TAG}>#{page.content}</#{TAG}>",
        { :asset_root => src }
      )
      page.content = filter.call.search(TAG).children.to_xml
    end
  end
end
