# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jemoji/version"

Gem::Specification.new do |s|
  s.name        = "jemoji"
  s.summary     = "GitHub-flavored emoji plugin for Jekyll"
  s.version     = Jekyll::Jemoji::VERSION
  s.authors     = ["GitHub, Inc."]
  s.email       = "support@github.com"

  s.homepage = "https://github.com/jekyll/jemoji"
  s.licenses = ["MIT"]
  s.files    = ["lib/jemoji.rb"]

  s.required_ruby_version = ">= 2.1"

  s.add_dependency "activesupport", ">= 4.2.9", "< 6.0"
  s.add_dependency "gemoji", "~> 3.0"
  s.add_dependency "html-pipeline", "~> 2.2"
  s.add_dependency "jekyll", "~> 3.0"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rubocop", "~> 0.55.0"
end
