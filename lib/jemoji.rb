require 'jekyll'
require 'gemoji'
require 'html/pipeline'

module Jekyll
  class Emoji < Jekyll::Converter
    attr_reader :config
    safe true

    def src
      @src ||=
        if config.key?("emoji") && config["emoji"].key?("src")
          config["emoji"]["src"]
        else
          "https://assets.github.com/images/icons/"
        end
    end

    def matches(ext)
      ext == ".html"
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      HTML::Pipeline.new([HTML::Pipeline::EmojiFilter], {
        asset_root: src
      }).call(content)[:output].to_s
    end
  end
end
