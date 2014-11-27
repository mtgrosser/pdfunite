require 'pdfunite/version'
require 'tmpdir'
require 'pathname'
require 'cocaine'
require 'logger'

module Pdfunite
  
  class BinaryNotFound < StandardError; end
  
  class << self
    
    @@logger = nil
    
    # You can set a custom logger here
    def logger=(logger)
      @@logger = logger
    end
    
    def logger
      @@logger
    end
    
    @@binary = 'pdfunite'
    
    # You can set a custom pdfunite binary here
    def binary=(binary)
      @@binary = binary
    end
    
    def binary
      @@binary
    end
    
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
        files = args.flatten(1).inject({}) do |hsh, arg|
          idx = hsh.size
          data = block_given? ? yield(arg) : File.binread(arg)
          tmpfile = tmpdir.join("#{idx}.pdf")
          tmpfile.open('wb') { |f| f << data }
          hsh.update(:"f_#{idx}" => tmpfile.realpath.to_s)
        end
        cmdline = Cocaine::CommandLine.new(binary, "#{files.keys.map(&:inspect).join(' ')} :outfile", logger: Pdfunite.logger || Logger.new(STDOUT))
        outfile = tmpdir.join('output.pdf')
        begin
          cmdline.run(files.merge(outfile: outfile.to_s))
        rescue Cocaine::CommandNotFoundError
          raise BinaryNotFound, "The pdfunite executable could not be found at #{binary.inspect}. Check the pdfunite README for more info."
        end
        output = outfile.binread
      end
      output
    end
  end
  
end
