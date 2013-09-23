Gem::Specification.new do |s|
  s.name = 'unsavory'
  s.version = '1.0.2'
  s.author = 'Michael Kohl'
  s.email = 'citizen428@gmail.com'
  s.summary = 'Removes outdated links from your Pinboard bookmarks'
  s.homepage = 'http://github.com/citizen428/unsavory'
  s.require_paths = %w[lib]
  s.files = %w[lib/pinboard.rb bin/unsavory ./LICENSE ./README.rdoc]
  s.executable = 'unsavory'
  s.add_dependency('httparty', '>= 0.4.3')
  s.add_dependency('progressbar', '>= 0.9.0')
  s.has_rdoc = false
end
