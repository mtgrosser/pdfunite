require 'pdfunite/version'
require 'tmpdir'
require 'pathname'
require 'open3'
require 'shellwords'
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
        files = args.flatten(1).collect.with_index do |arg, idx|
          realpath = if block_given?
            data = yield(arg)
            file = tmpdir.join("#{idx}.pdf")
            file.binwrite data.force_encoding('BINARY')
            file.realpath
          else
            Pathname.new(arg).realpath
          end
          realpath.to_s
        end
        outfile = tmpdir.join('output.pdf')
        cmdline = [binary.to_s, *files, outfile.to_s]
        output = outfile.binread if run_command(cmdline.shelljoin)
      end
      output
    end

    private
  
    def run_command(cmdline)
      logger = Pdfunite.logger || Logger.new(STDOUT)
      _, stderr, status = Open3.capture3(cmdline)
      logger.info "Pdfunite: #{cmdline}"
      raise unless status.success?
      true
    rescue Errno::ENOENT
      raise BinaryNotFound, "The pdfunite executable could not be found at #{binary.inspect}. Check the pdfunite README for more info."
    rescue => e
      logger.error "Pdfunite error: #{e}\ncommand: #{cmdline}\nerror: #{stderr}"
      false
    end

  end
end
