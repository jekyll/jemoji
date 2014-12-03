require 'jekyll'
require 'gemoji'
require 'html/pipeline'

module Jekyll
  class Emoji < Jekyll::Generator
    attr_reader :config
    safe true

    def initialize(config = {})
      @config = config
    end

    def src
      @src ||=
        if config.key?("emoji") && config["emoji"].key?("src")
          config["emoji"]["src"]
        else
          "https://assets.github.com/images/icons/"
        end
    end

    def filter
      @filter ||= HTML::Pipeline::EmojiFilter.new(nil, { :asset_root => src })
    end

    def generate(site)
      site.pages.each { |page| emojify page }
      site.posts.each { |post| emojify post }
      site.docs_to_write.each { |doc| emojify doc }
    end

    def emojify(page)
      page.content = filter.emoji_image_filter(page.content)
    end
  end
end
