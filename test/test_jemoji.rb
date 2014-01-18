require 'helper'

class TestJemoji < Test::Unit::TestCase

  def setup
    @site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
    @jemoji = Jekyll::Jemoji.new()
    @jemoji.instance_variable_set "@site", @site
    @page = Jekyll::Page.new(@site, File.expand_path("../../", __FILE__), "", "README.md")
    @page.instance_variable_set "@content", ":+1:"
    @site.pages.push @page
    @img = '<img src="https://github.global.ssl.fastly.net/images/icons/emoji/+1.png" alt="+1" class="emoji" height="20" />'
  end

  should "retrieve emoji list" do
    assert_instance_of Array, @jemoji.emoji
    assert_equal false, @jemoji.emoji.empty?
  end

  should "build regex" do
    assert_instance_of Regexp, @jemoji.regex
    assert_match @jemoji.regex, ":+1:"
    assert_no_match @jemoji.regex, "+1:"
    assert_no_match @jemoji.regex, "+1:"
    assert_no_match @jemoji.regex, "+1"
  end

  should "generate image tag" do
    assert_equal @img, @jemoji.img("+1")
  end

  should "replace emoji with img" do
    @jemoji.emojify @page
    assert_equal @img, @page.content
  end

  should "replace page content on generate" do
    @jemoji.generate(@site)
    assert_equal @img, @site.pages.first.content
  end

  should "pull src from config" do
    @site.config["emoji"] = {"src" => "/foo"}
    assert_match /^\/foo$/, @jemoji.src
  end

end
