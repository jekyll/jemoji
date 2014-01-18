Gem::Specification.new do |s|
  s.name = "jemoji"
  s.summary = "GitHub-flavored emoji plugin for Jekyll"
  s.description = ""
  s.version = "0.0.1"
  s.authors = ["Ben Balter"]
  s.email = "ben.balter@github.com"
  s.homepage = "https://github.com/benbalter/jemoji"
  s.licenses = ["MIT"]
  s.files = [ "lib/jemoji.rb" ]
  s.add_dependency( "jekyll" )
  s.add_dependency( "gemoji" )
end
