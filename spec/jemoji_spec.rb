RSpec.describe(Jekyll::Emoji) do
  let(:config_overrides) { {} }
  let(:configs) do
    Jekyll.configuration(config_overrides.merge({
      'skip_config_files' => false,
      'collections' => { 'docs' => { 'output' => true }, 'secret' => {} },
      'source' => fixtures_dir,
      'destination' => fixtures_dir('_site')
    }))
  end
  let(:site) { Jekyll::Site.new(configs) }
  let(:emoji) { site.generators.find { |g| g.class.name.eql?("Jekyll::Emoji") } }
  let(:default_src) { "https://assets.github.com/images/icons/" }
  let(:result) { "<img class='emoji' title=':+1:' alt=':+1:' src='#{default_src}emoji/unicode/1f44d.png' height='20' width='20' align='absmiddle' />" }
  let(:v3?) { ::Jekyll::VERSION.to_f >= 3.0 }
  let(:posts) { v3? ? site.posts.docs : site.posts }

  before(:each) do
    site.read
    (site.pages + posts + site.docs_to_write).each { |p| p.content.strip! }
    site.generate
  end

  it "is instantiated properly with the site" do
    expect(emoji).not_to be(nil)
    expect(emoji).to be_a(Jekyll::Emoji)
  end

  it "creates a filter" do
    expect(emoji.filter).to be_a(HTML::Pipeline::EmojiFilter)
  end

  it "has a default source" do
    expect(emoji.src).to eql(default_src)
  end

  it "saves the site config for later use" do
    expect(emoji.config).to eql(site.config)
  end

  it "correctly replaces the emoji with the img in posts" do
    expect(posts.first.content).to eql(result)
  end

  it "correctly replaces the emoji with the img in pages" do
    expect(site.pages.first.content).to eql(result)
  end

  it "correctly replaces the emoji with the img in collection documents" do
    expect(site.collections["docs"].docs.first.content).to eql(result)
  end

  it "does not replace the emoji if the collection document is not to be output" do
    expect(site.collections["secret"].docs.first.content).to eql(":+1:\n")
  end

  it "does not mangle liquid templates" do
    expect(site.collections["docs"].docs.last.content).to eql(
      "#{result} <a href=\"{{ page.url }}\">{{ page.path }}</a>"
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
      expect(emoji.src).to eql(emoji_src)
    end

    it "respects the new base when emojifying" do
      expect(posts.first.content).to eql(result.sub(default_src, emoji_src))
    end
  end
end
