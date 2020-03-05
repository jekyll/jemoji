## v0.12.0 / 2020-03-05

### Minor Enhancements

  * perf: don&#39;t load Gemoji into memory immediately (#106)

### Development Fixes

  * deps: Ruby > 2.4 (EOL)
  * ci: test with Ruby 2.7

## v0.11.1 / 2019-08-08

### Bug Fixes

  * Support handling body tag across multiple lines (#96)

## v0.11.0 / 2019-03-23

  * Test against Jekyll v4

## v0.10.2 / 2019-02-13

### Bug Fixes

  * fix: update asset host URL (#90)

### Development Fixes

  * chore(deps): rubocop-jekyll 0.3 (#86)

## v0.10.1 / 2018-08-06

### Bug Fixes

  * Do not match the body tag eagerly (#82)

## v0.10 / 2018-05-02

### Minor Enhancements

  * Let Nokogiri parse only the necessary markup (#74)
  * Drop support for Ruby 2.2 (#77)
  * Drop dependency on ActiveSupport (#78)

### Development Fixes

  * Relax version constraint on ActiveSupport (#76)
  * Bump Rubocop to v0.55.x (#75)
  * Test against Ruby 2.5 (#71)

## v0.9.0 / 2017-12-03

  * Drop Support for Jekyll 2
  * Require Ruby 2.1
  * Adopt Jekyll's Ruby Styleguide (#59)
  * Define path with __dir__ (#64)
  * Move version to its own file for easier bumping

## v0.8.1 / 2017-09-21

  * Remove align attribute for HTML5 compability (#58)
  * Require activesupport >= 4.2.9 (#62)
  * Bump Ruby versions for Travis (#66)

## v0.8.0 / 2017-02-03

  * Update to Gemoji 3.0. (#55)

## v0.7.0 / 2016-07-17

  * Add support for setting a default asset host URL in an ASSET_HOST_URL environment variable (#45)
  * Lock activesupport down to v4.x (#47)

## v0.6.2 / 2016-03-19

  * Don't strip html, body, and head tags (#37)
  * Use String#include instead of String#=~ (#39)

## v0.6.1 / 2016-03-09

  * Handle subclassing of Jekyll::Page (#34)

## v0.6.0 / 2016-03-08

  * jemoji as a hook: better guarding against accidents (#33)

## v0.5.0 / 2015-05-09

  * Relax dependency on Jekyll to support >= 2.0. (#19)
  * Travis: add 2.2 to build matrix, remove 1.9.3, only master branch build (#20)

## v0.4.0 / 2014-12-02

  * Emojify Collection Documents as well (#14)
  * Rewrite tests to use RSpec 3 instead of Minitest (#15)

## v0.3.0 / 2014-07-29

  * Upgrade to Gemoji 2.0 and HTML Pipeline 1.9 (#11)
