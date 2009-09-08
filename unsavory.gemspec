Gem::Specification.new do |s| 
  s.name = 'unsavory' 
  s.version = '0.3.0' 
  s.author = 'Michael Kohl'
  s.email = 'citizen428@gmail.com'
  s.summary = 'Removes outdated links from your Delicious bookmarks'
  s.require_paths = %w[lib] 
  s.files = %w[lib/delicious.rb bin/unsavory ./LICENSE ./README.rdoc]
  s.executable = 'unsavory'
  s.add_dependency('httparty', '>= 0.4.3')
  s.has_rdoc = false 
end 
