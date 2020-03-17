# frozen_string_literal: true

require_relative "lib/jemoji/version"

Gem::Specification.new do |s|
  s.name        = "jemoji"
  s.summary     = "GitHub-flavored emoji plugin for Jekyll"
  s.version     = Jekyll::Jemoji::VERSION
  s.authors     = ["GitHub, Inc."]
  s.email       = "support@github.com"

  s.homepage = "https://github.com/jekyll/jemoji"
  s.licenses = ["MIT"]
  s.files    = ["lib/jemoji.rb"]

  s.required_ruby_version = ">= 2.4.0"

  s.add_dependency "gemoji", "~> 3.0"
  s.add_dependency "html-pipeline", "~> 2.2"
  s.add_dependency "jekyll", ">= 3.0", "< 5.0"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake", "~> 12.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rubocop-jekyll", "~> 0.4"
end
