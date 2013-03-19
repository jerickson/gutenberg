Gem::Specification.new do |gem|
  gem.name        = 'gutenberg'
  gem.version      = '0.0.0'
  gem.date        = '2013-03-19'
  gem.summary       = "Project Gutenberg Book Parser"
  gem.description   = "A simple gutenberg book file parser"
  gem.authors       = ["Jon Erickson"]
  gem.email         = 'jon.e.erickson@gmail.com'
  gem.files         = `git ls-files`.split($\)
  gem.require_paths =  ['lib/']
  gem.homepage      = 'http://github.com/'
end
