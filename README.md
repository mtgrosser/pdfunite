[![Gem Version](https://badge.fury.io/rb/pdfunite.svg)](http://badge.fury.io/rb/pdfunite)
[![build](https://github.com/mtgrosser/pdfunite/actions/workflows/build.yml/badge.svg)](https://github.com/mtgrosser/pdfunite/actions/workflows/build.yml)
# Pdfunite

Merge PDF files with Ruby.

Pdfunite is a Ruby wrapper for the pdfunite command line tool. No Java required.

## Installation

Pdfunite requires the ```pdfunite``` command line tool, which uses the `poppler` library.

### Linux

Install the `poppler-utils` package using your package manager.

### OS X

Install `poppler` using Homebrew.

### In your app

Add this line to your application's Gemfile:

```ruby
# Gemfile
gem 'pdfunite'
```

## Usage

```ruby
# Join existing PDF files
pdf_data = Pdfunite.join('file1.pdf', 'file2.pdf', 'file3.pdf')
File.open('joined.pdf', 'wb') { |f| f << pdf_data }

# Join PDF binary data provided by a collection of objects
pdf_data = Pdfunite.join(objects) { |obj| obj.to_pdf }

# Set path to pdfunite binary if not on PATH
Pdfunite.binary = '/opt/local/bin/pdfunite'

# Set custom logger
Pdfunite.logger = Logger.new('pdfunite.log')
```
