Gem::Specification.new do |s|
  s.name = "jemoji"
  s.summary = "GitHub-flavored emoji plugin for Jekyll"
  s.description = ""
  s.version = "0.1.0"
  s.authors = ["GitHub, Inc."]
  s.email = "support@github.com"
  s.homepage = "https://github.com/jekyll/jemoji"
  s.licenses = ["MIT"]
  s.files = [ "lib/jemoji.rb" ]
  s.add_dependency( "jekyll", '~> 1.4')
  s.add_dependency( "html-pipeline", '~> 1.5.0' )
  s.add_dependency( "gemoji", '~> 1.5.0' )
end
