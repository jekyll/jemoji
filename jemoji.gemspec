Gem::Specification.new do |s|
  s.name = "jemoji"
  s.summary = "GitHub-flavored emoji plugin for Jekyll"
  s.description = ""
  s.version = "0.0.7"
  s.authors = ["GitHub, Inc."]
  s.email = "support@github.com"
  s.homepage = "https://github.com/github/jemoji"
  s.licenses = ["MIT"]
  s.files = [ "lib/jemoji.rb" ]
  s.add_dependency( "jekyll" )
  s.add_dependency( "gemoji" )
  s.add_dependency( "html-pipeline" )
end
