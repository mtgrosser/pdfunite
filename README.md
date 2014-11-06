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

# Join PDF binary data provided by a collection of objects
pdf_data = Pdfunite.join(objects) { |obj| obj.to_pdf }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pdfunite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
