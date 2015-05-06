require 'jekyll'
require 'gemoji'
require 'html/pipeline'

module Jekyll
  class Emoji < Jekyll::Converter
    attr_reader :config
    safe true
    priority :low

    EMOJIABLE_EXTS = %w{.html .htm .md .markdown .mkdn .mkd .textile}

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

    def matches(ext)
      EMOJIABLE_EXTS.include?(ext.downcase)
    end

    def output_ext(*)
      ".html".freeze
    end

    def convert(content)
      filter.emoji_image_filter(content)
    end
  end
end
