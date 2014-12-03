RSpec.describe(Jekyll::Emoji) do
  let(:config_overrides) { {} }
  let(:configs) do
    Jekyll.configuration(config_overrides.merge({
      'skip_config_files' => true,
      'collections' => { 'docs' => { 'output' => true }, 'secret' => {} },
      'source' => fixtures_dir,
      'destination' => fixtures_dir('_site')
    }))
  end
  let(:site) { Jekyll::Site.new(configs) }
  let(:emoji) { site.generators.find { |g| g.class.name.eql?("Jekyll::Emoji") } }
  let(:result) { "<img class='emoji' title=':+1:' alt=':+1:' src='https://assets.github.com/images/icons/emoji/unicode/1f44d.png' height='20' width='20' align='absmiddle' />" }

  before(:each) do
    site.read
    (site.pages + site.posts + site.docs_to_write).each { |p| p.content.strip! }
    site.generate
  end

  it "is instantiated properly with the site" do
    expect(emoji).not_to be(nil)
  end

  it "correctly replaces the emoji with the img in posts" do
    expect(site.posts.first.content).to eql(result)
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
    let(:emoji_src) { "http://mine.club" }
    let(:config_overrides) do
      {
        "emoji" => { "src" => emoji_src }
      }
    end

    it "respects the new base" do
      expect(site.posts.first.content).to eql(result.sub('https://assets.github.com/images/icons', emoji_src))
    end
  end
end
