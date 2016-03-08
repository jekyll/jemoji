Gem::Specification.new do |s|
  s.name        = 'jemoji'
  s.summary     = 'GitHub-flavored emoji plugin for Jekyll'
  s.version     = '0.6.0'
  s.authors     = ['GitHub, Inc.']
  s.email       = 'support@github.com'

  s.homepage = 'https://github.com/jekyll/jemoji'
  s.licenses = ['MIT']
  s.files    = [ 'lib/jemoji.rb' ]

  s.add_dependency 'jekyll', '>= 3.0'
  s.add_dependency 'html-pipeline', '~> 2.2'
  s.add_dependency 'gemoji', '~> 2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '~> 3.0'
end
