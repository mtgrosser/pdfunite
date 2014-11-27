require_relative '../test_helper'

class PdfuniteTest < Minitest::Test
  def setup
    @files = (1..4).map { |i| root.join('data', "#{i}.pdf").to_s }
  end
  
  def test_joining_existing_pdf_files
    assert_pdf Pdfunite.join(@files)
  end
  
  def test_joining_pdf_data_provided_by_generic_objects
    assert_pdf Pdfunite.join(@files) { |file| File.binread(file) }
  end
  
  def test_calling_with_multiple_args
    assert_pdf Pdfunite.join(*@files)
  end
  
  def test_setting_custom_logger
    Dir.mktmpdir do |dir|
      logfile = Pathname.new(dir).join('pdfunite.log')
      assert_equal false, logfile.exist?
      Pdfunite.logger = Logger.new(logfile.to_s)
      assert_pdf Pdfunite.join(@files)
      assert_equal true, logfile.exist?
      assert logfile.read.size > 0
    end
  ensure
    Pdfunite.logger = nil
  end
  
  def test_setting_custom_binary
    Pdfunite.binary = 'foobar123456123456'
    assert_raises Pdfunite::BinaryNotFound do
      Pdfunite.join(@files)
    end
  ensure
    Pdfunite.binary = 'pdfunite'
  end
  
  private
  
  def root
    Pathname.new(File.dirname(__FILE__)).join('..').realpath
  end
  
  def assert_pdf(data)
    fail "pdf data expected, got nil" if data.nil?
    assert data.start_with?("%PDF-1.4"), 'no valid PDF data'
  end
end