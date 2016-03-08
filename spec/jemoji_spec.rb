RSpec.describe(Jekyll::Emoji) do
  Jekyll.logger.log_level = :error

  let(:config_overrides) { {} }
  let(:configs) do
    Jekyll.configuration(config_overrides.merge({
      'skip_config_files' => false,
      'collections'       => { 'docs' => { 'output' => true }, 'secret' => {} },
      'source'            => fixtures_dir,
      'destination'       => fixtures_dir('_site')
    }))
  end
  let(:emoji)       { described_class }
  let(:site)        { Jekyll::Site.new(configs) }
  let(:default_src) { "https://assets.github.com/images/icons/" }
  let(:result)      { "<img class=\"emoji\" title=\":+1:\" alt=\":+1:\" src=\"#{default_src}emoji/unicode/1f44d.png\" height=\"20\" width=\"20\" align=\"absmiddle\">" }
  let(:posts)       { site.posts.docs }

  def para(content)
    "<p>#{content}</p>\n"
  end

  before(:each) do
    site.read
    (site.pages + posts + site.docs_to_write).each { |p| p.content.strip! }
    site.render
  end

  it "creates a filter" do
    expect(emoji.filters[default_src]).to be_a(HTML::Pipeline)
  end

  it "has a default source" do
    expect(emoji.emoji_src).to eql(default_src)
  end

  it "correctly replaces the emoji with the img in posts" do
    expect(posts.first.output).to eql(para(result))
  end

  it "correctly replaces the emoji with the img in pages" do
    expect(site.pages.first.output).to eql(para(result))
  end

  it "correctly replaces the emoji with the img in collection documents" do
    expect(site.collections["docs"].docs.first.output).to eql(para(result))
  end

  it "does not replace the emoji if the collection document is not to be output" do
    expect(site.collections["secret"].docs.first.output).to eql(para(":+1:"))
  end

  it "does not mangle liquid templates" do
    expect(site.collections["docs"].docs.last.output).to eql(
      para("#{result} <a href=\"/docs/with_liquid.html\">_docs/with_liquid.md</a>")
    )
  end

  context "with a different base for jemoji" do
    let(:emoji_src) { "http://mine.club/" }
    let(:config_overrides) do
      {
        "emoji" => { "src" => emoji_src }
      }
    end

    it "fetches the custom base from the config" do
      expect(emoji.emoji_src(site.config)).to eql(emoji_src)
    end

    it "respects the new base when emojifying" do
      expect(posts.first.output).to eql(para(result.sub(default_src, emoji_src)))
    end
  end
end
