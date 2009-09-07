Gem::Specification.new do |s| 
  s.name = 'unsavory' 
  s.version = '0.3.0' 
  s.author = 'Michael Kohl'
  s.email = 'citizen428@gmail.com'
  s.summary = 'Removes outdated links from your Delicious bookmarks'
  s.require_paths = 'lib' 
  s.files = ['lib/delicious.rb', './unsavory']
  s.executable = 'unsavory'
  s.add_dependency('httparty', '>= 0.4.3')
  s.has_rdoc = false 
end 
