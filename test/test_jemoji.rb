require 'helper'

class TestJemoji < Test::Unit::TestCase

  def setup
    @site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
    @jemoji = Jekyll::Jemoji.new()
    @jemoji.instance_variable_set "@site", @site
    @page = Jekyll::Page.new(@site, File.expand_path("../../", __FILE__), "", "README.md")
    @page.instance_variable_set "@content", ":+1:"
    @site.pages.push @page
    @img = "<img class=\"emoji\" title=\":+1:\" alt=\":+1:\" src=\"http://assets.github.com/images/icons/emoji/%2B1.png\" height=\"20\" width=\"20\" align=\"absmiddle\">"
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
