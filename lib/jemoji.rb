# frozen_string_literal: true

require "jekyll"
require "html/pipeline"

module Jekyll
  class Emoji
    GITHUB_DOT_COM_ASSET_HOST_URL = "https://github.githubassets.com"
    ASSET_PATH = "/images/icons"
    DEFAULT_DIR = "/emoji"
    FILE_NAME = "/:file_name"
    BODY_START_TAG = "<body"
    OPENING_BODY_TAG_REGEX = %r!<body(.*?)>\s*!m.freeze

    class << self
      def emojify(doc)
        return unless doc.output&.match?(HTML::Pipeline::EmojiFilter.emoji_pattern)

        doc.output = if doc.output.include? BODY_START_TAG
                       replace_document_body(doc)
                     else
                       src_root = emoji_src_root(doc.site.config)
                       asset_path = emoji_asset_path(doc.site.config)
                       filter_with_emoji(src_root, asset_path).call(doc.output)[:output].to_s
                     end
      end

      # Public: Create or fetch the filter for the given {{src_root}} asset root.
      #
      # src_root - the asset root URL (e.g. https://github.githubassets.com/images/icons/)
      # asset_path - the asset sub-path of src (e.g. "/images/icons")
      #
      # if asset_path it's not provided by user in _config.yml file, html pipeline module
      # will default it to value "emoji"
      #
      # examples of _config.yml:
      #   1. user provided all URLs:
      #       emoji:
      #           src: https://example.com/asset
      #           asset: /images/png
      #   emoji files will serve from https://example.com/asset/images/png
      #
      #   2. user provided just src:
      #       emoji:
      #           src: https://example.com/asset
      #   emoji files will serve from https://example.com/emoji
      #
      #   3. user provided nothing:
      #   emoji files will serve from https://github.githubassets.com/images/icons/emoji
      #
      # Returns an HTML::Pipeline instance for the given asset root.
      def filter_with_emoji(src_root, asset_path)
        filters[src_root] ||= HTML::Pipeline.new([
          HTML::Pipeline::EmojiFilter,
        ], :asset_root => src_root, :asset_path => asset_path, :img_attrs => { :align => nil })
      end

      # Public: Filters hash where the key is the asset root source.
      # Effectively a cache.
      def filters
        @filters ||= {}
      end

      # Public: Calculate the asset root source for the given config.
      # The custom emoji asset root can be defined in the config as
      # emoji.src_root, and must be a valid URL (i.e. it must include a
      # protocol and valid domain)
      #
      # config - the hash-like configuration of the document's site
      #
      # Returns a full URL to use as the asset root URL. Defaults to the root
      # URL for assets provided by an ASSET_HOST_URL environment variable,
      # otherwise the root URL for emoji assets at assets-cdn.github.com.
      def emoji_src_root(config = {})
        if config.key?("emoji") && config["emoji"].key?("src")
          config["emoji"]["src"]
        else
          default_asset_root
        end
      end

      # Public: Calculate the asset path for the given config.
      # The custom emoji asset root can be defined in the config as
      # emoji.asset.
      #
      # If emoji.asset isn't defined, its value will explicitly set to "emoji"
      #
      # config - the hash-like configuration of the document's site
      #
      # Returns a string to use as the asset path. Defaults to the ASSET_PATH/emoji.
      def emoji_asset_path(config = {})
        if config.key?("emoji") && config["emoji"].key?("src")
          if config["emoji"].key?("asset")
            # Ensure that any trailing "/" in asset path is trimmed
            # because FILE_NAME starts with a "/"
            config["emoji"]["asset"].chomp("/") + FILE_NAME.to_s
          else
            "#{DEFAULT_DIR}#{FILE_NAME}"
          end
        else
          # Avoid breaking existing installations by appending DEFAULT_DIR ("/emoji")
          # to ASSET_PATH ("/images/icons")
          "#{ASSET_PATH}#{DEFAULT_DIR}#{FILE_NAME}"
        end
      end

      # Public: Defines the conditions for a document to be emojiable.
      #
      # doc - the Jekyll::Document or Jekyll::Page
      #
      # Returns true if the doc is written & is HTML.
      def emojiable?(doc)
        (doc.is_a?(Jekyll::Page) || doc.write?) &&
          doc.output_ext == ".html" || doc.permalink&.end_with?("/")
      end

      private

      def default_asset_root
        if !ENV["ASSET_HOST_URL"].to_s.empty?
          # Ensure that any trailing "/" is trimmed
          asset_host_url = ENV["ASSET_HOST_URL"].chomp("/")
          asset_host_url.to_s
        else
          GITHUB_DOT_COM_ASSET_HOST_URL.to_s
        end
      end

      def replace_document_body(doc)
        src_root = emoji_src_root(doc.site.config)
        asset_path = emoji_asset_path(doc.site.config)
        head, opener, tail = doc.output.partition(OPENING_BODY_TAG_REGEX)
        body_content, *rest = tail.partition("</body>")
        processed_markup = filter_with_emoji(src_root, asset_path).call(body_content)[:output].to_s
        String.new(head) << opener << processed_markup << rest.join
      end
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  Jekyll::Emoji.emojify(doc) if Jekyll::Emoji.emojiable?(doc)
end
