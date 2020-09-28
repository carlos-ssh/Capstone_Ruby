require 'colorize'

class FileReader
  attr_reader :err_msg, :file_lines, :file_path, :file_line_count

  def initialize(file_path)
    @err_msg = ''
    @file_path = file_path
    begin
      @file_lines = File.readlines(@file_path)

end
