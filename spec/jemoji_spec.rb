require "spec_helper"

RSpec.describe(Jekyll::Emoji) do
  let(:config_overrides) { {} }
  let(:default_src) { "https://assets.github.com/images/icons/" }
  let(:result) { "<img class=\"emoji\" title=\":+1:\" alt=\":+1:\" src=\"#{default_src}emoji/unicode/1f44d.png\" height=\"20\" width=\"20\" align=\"absmiddle\">" }
  let(:converter) { described_class.new(config_overrides.merge({})) }

  it "replaces emoji in markup" do
    expect(converter.convert("<p>:+1:</p>")).to eq "<p>#{result}</p>"
  end

  it "doesn't replace within a code block" do
    expect(converter.convert("<code>:+1:</code>")).to eq "<code>:+1:</code>"
  end

  context "with a different base for jemoji" do
    let(:emoji_src) { "http://mine.club/" }
    let(:config_overrides) do
      {
        "emoji" => { "src" => emoji_src }
      }
    end

    it "fetches the custom base from the config" do
      expect(converter.src).to eql(emoji_src)
    end

    it "respects the new base when emojifying" do
      expect(converter.convert(":+1:")).to eql(result.sub(default_src, emoji_src))
    end
  end
end
