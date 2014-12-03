require 'helper'

class TestJemoji < Minitest::Test
<<<<<<< HEAD
  FIXTURES_DIR = File.join(File.dirname(__FILE__), "fixtures")

  def setup
    @site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS.merge({"source" => FIXTURES_DIR, "collections" => {"docs" => {}}}))
    @jemoji = Jekyll::Jemoji.new()
    @jemoji.instance_variable_set "@site", @site
    @page = Jekyll::Page.new(@site, FIXTURES_DIR, "", "file.md")
    @page.instance_variable_set "@content", ":+1:"
    @site.pages.push @page
=======
  include JemojiTestHelpers

  def setup
    @site = fixture_site
    @jemoji = @site.generators.find { |g| g.class.name.eql?("Jekyll::Jemoji") }
    @site.read
    @site.pages.first.content.strip!
    @site.process
    @page = @site.pages.first
>>>>>>> Begin to revamp tests.
    @img = "<img class='emoji' title=':+1:' alt=':+1:' src='https://assets.github.com/images/icons/emoji/unicode/1f44d.png' height='20' width='20' align='absmiddle' />"
  end

  def test_replace_emoji_with_img
    assert_equal @img, @page.output
  end

  should "replace emoji with img" do
    @jemoji.emojify @page
    assert_equal @img, @page.content
  end

  should "replace page content on generate" do
    @jemoji.generate(@site)
    assert_equal @img, @site.pages.first.content
  end

  should "replace collection content on generate" do
    @site.process
    document = @site.collections["docs"].docs.first
    @jemoji.generate(@site)
    @jemoji.emojify document
    assert_equal @img, document.content.strip
  end

  should "pull src from config" do
    @jemoji.config["emoji"] = {"src" => "/foo"}
    assert_match /^\/foo$/, @jemoji.src
  end

  should "not mangle liquid templates" do
    @jemoji.instance_variable_set "@filter", HTML::Pipeline::EmojiFilter.new(nil, { :asset_root => @jemoji.src })
    page = Jekyll::Page.new(@site, FIXTURES_DIR, "", "file.md")
    page.instance_variable_set "@content", ":+1: <a href='{{ page.permalink }}'>foo</a>"

    @jemoji.emojify page
    assert_equal "#{@img} <a href='{{ page.permalink }}'>foo</a>", page.content
  end

end
