# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fbo/version'

Gem::Specification.new do |spec|
  spec.name          = 'fbo'
  spec.version       = FBO::VERSION
  spec.authors       = ['Chris Kottom']
  spec.email         = ['chris@chriskottom.com']
  spec.summary       = 'Parse and process FBO bulk listings'
  spec.description   = <<-EOF
    The FBO gem manages the process of downloading and parsing file-based notice
    information from the Federal Business Opportunities (https://www.fbo.gov/)
    application / database. The FBO feed files include new and updated
    opportunities, information about awarded contracts, and other details
    concerning the offer and disposition of federal government contracts and
    tenders.
  EOF
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 4.7.5'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'turn'
end
