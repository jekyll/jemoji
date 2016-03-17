require 'jekyll'
require 'gemoji'
require 'gemoji-parser'
require 'html/pipeline'

module Jekyll
  class Emoji
    GITHUB_DOT_COM_ASSET_ROOT = "https://assets.github.com/images/icons/".freeze

    class << self
      def emojify(doc)
        src = emoji_src(doc.site.config)
        # tokenize the raw input unicode emoji into token symbol form
        doc.output = EmojiParser.tokenize(doc.output)
        doc.output = filter_with_emoji(src).call(doc.output)[:output].to_s
      end

      # Public: Create or fetch the filter for the given {{src}} asset root.
      #
      # src - the asset root URL (e.g. https://assets.github.com/images/icons/)
      #
      # Returns an HTML::Pipeline instance for the given asset root.
      def filter_with_emoji(src)
        filters[src] ||= HTML::Pipeline.new([
          HTML::Pipeline::EmojiFilter
        ], { :asset_root => src })
      end

      # Public: Filters hash where the key is the asset root source.
      # Effectively a cache.
      def filters
        @filters ||= {}
      end

      # Public: Calculate the asset root source for the given config.
      # The custom emoji asset root can be defined in the config as
      # emoji.src, and must be a valid URL (i.e. it must include a
      # protocol and valid domain)
      #
      # config - the hash-like configuration of the document's site
      #
      # Returns a full URL to use as the asset root URL. Defaults to
      # the assets.github.com emoji root.
      def emoji_src(config = {})
        if config.key?("emoji") && config["emoji"].key?("src")
          config["emoji"]["src"]
        else
          GITHUB_DOT_COM_ASSET_ROOT
        end
      end

      # Public: Defines the conditions for a document to be emojiable.
      #
      # doc - the Jekyll::Document or Jekyll::Page
      #
      # Returns true if the doc is written & is HTML.
      def emojiable?(doc)
        (doc.is_a?(Jekyll::Page) || doc.write?) &&
          doc.output_ext == ".html" || (doc.permalink && doc.permalink.end_with?("/"))
      end
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  Jekyll::Emoji.emojify(doc) if Jekyll::Emoji.emojiable?(doc)
end
