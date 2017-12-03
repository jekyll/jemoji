Gem::Specification.new do |s|
  s.name        = "jemoji"
  s.summary     = "GitHub-flavored emoji plugin for Jekyll"
  s.version     = "0.8.1"
  s.authors     = ["GitHub, Inc."]
  s.email       = "support@github.com"

  s.homepage = "https://github.com/jekyll/jemoji"
  s.licenses = ["MIT"]
  s.files    = [ "lib/jemoji.rb" ]

  s.required_ruby_version = ">= 2.1"

  s.add_dependency "activesupport", "~> 4.0", ">= 4.2.9"
  s.add_dependency "gemoji", "~> 3.0"
  s.add_dependency "html-pipeline", "~> 2.2"
  s.add_dependency "jekyll", "~> 3.0"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rubocop", "~> 0.51"
end
