# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdfunite/version'

Gem::Specification.new do |spec|
  spec.name          = 'pdfunite'
  spec.version       = Pdfunite::VERSION
  spec.date          = '2014-12-06'
  spec.authors       = ['Matthias Grosser']
  spec.email         = ['mtgrosser@gmx.net']
  spec.summary       = %q{Merge PDF files with Ruby - no Java required}
  spec.description   = %q{A Ruby wrapper for the pdfunite command line tool}
  spec.homepage      = 'https://github.com/mtgrosser/pdfunite'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG', 'Rakefile']
  spec.require_paths = ['lib']

  spec.add_dependency 'cocaine', '~> 0.5'
  
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'minitest', '>= 5.0'
end
