RSpec.describe(Jekyll::Emoji) do
  let(:config_overrides) { {} }
  let(:configs) do
    Jekyll.configuration(config_overrides.merge({
      'skip_config_files' => true,
      'source' => fixtures_dir,
      'destination' => fixtures_dir('_site')
    }))
  end
  let(:site) { Jekyll::Site.new(configs) }
  let(:emoji) { site.generators.find { |g| g.class.name.eql?("Jekyll::Emoji") } }
  let(:result) { "<img class='emoji' title=':+1:' alt=':+1:' src='https://assets.github.com/images/icons/emoji/unicode/1f44d.png' height='20' width='20' align='absmiddle' />" }

  it "is instantiated properly with the site" do
    expect(emoji).not_to be(nil)
  end

  it "correctly replaces the emoji with the img in posts"
  it "correctly replaces the emoji with the img in pages"
  it "correctly replaces the emoji with the img in collection documents"
  it "does not mangle liquid templates"

  context "with a different base for jemoji" do
    it "respects the new base"
  end
end
