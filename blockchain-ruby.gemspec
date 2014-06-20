# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "blockchain"
  gem.version       = "0.1.0"
  gem.authors       = ["James Larisch"]
  gem.email         = ["root@jameslarisch.com"]
  gem.description   = "Convenient wrapper around public Blockchain.info API."
  gem.summary       = "Convenient wrapper around public Blockchain.info API."
  gem.homepage      = "https://github.com/zenchilabs/blockchain-ruby"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]


  gem.add_development_dependency "rspec", "~> 3.0.0"
  gem.add_development_dependency "fakeweb", "~> 1.3.0"
  gem.add_development_dependency "rake"

  gem.add_dependency "money", "~> 6.1.1"
  gem.add_dependency "monetize", "~> 0.3.0"
  gem.add_dependency "bitcoin-money", "~> 0.5.1"
end