# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdfunite/version'

Gem::Specification.new do |spec|
  spec.name          = "pdfunite"
  spec.version       = Pdfunite::VERSION
  spec.authors       = ["Matthias Grosser"]
  spec.email         = ["mtgrosser@gmx.net"]
  spec.summary       = %q{Merge PDF files with Ruby}
  spec.description   = %q{Ruby wrapper for the pdfunite command line tool. No Java required}
  spec.homepage      = "https://github.com/mtgrosser/pdfunite"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cocaine", "~> 0.5"
  
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'minitest', ">= 5.0"
end
