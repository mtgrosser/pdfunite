require 'pdfunite/version'
require 'pathname'
require 'cocaine'

module Pdfunite
  
  # You can set a custom logger here
  mattr_accessor :logger
  
  class << self
    #
    # Join PDF files or PDF data
    #
    # Pdfunite.join(filenames)
    # Pdfunite.join(objects) { |obj| obj.to_pdf }
    #
    def join(*args)
      output = nil
      Dir.mktmpdir do |dir|
        tmpdir = Pathname.new(dir).realpath
        files = Array.wrap(args).inject({}) do |hsh, arg|
          idx = hsh.size
          data = block_given? ? yield(arg) : File.binread(arg)
          tmpfile = tmpdir.join("#{idx}.pdf")
          tmpfile.open('wb') { |f| f << data }
          hsh.update(:"f_#{idx}" => tmpfile.realpath.to_s)
        end
        cmdline = Cocaine::CommandLine.new('pdfunite', "#{files.keys.map(&:inspect).join(' ')} :outfile", logger: Pdfunite.logger || Logger.new(STDOUT))
        outfile = tmpdir.join('output.pdf')
        cmdline.run(files.merge(outfile: outfile.to_s))
        output = outfile.binread
      end
      output
    end
  end
  
end
