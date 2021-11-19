# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdfunite/version'

Gem::Specification.new do |spec|
  spec.name          = 'pdfunite'
  spec.version       = Pdfunite::VERSION
  spec.authors       = ['Matthias Grosser']
  spec.email         = ['mtgrosser@gmx.net']
  spec.summary       = %q{Merge PDF files with Ruby - no Java required}
  spec.description   = %q{A Ruby wrapper for the pdfunite command line tool}
  spec.homepage      = 'https://github.com/mtgrosser/pdfunite'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
