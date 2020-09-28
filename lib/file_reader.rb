require 'colorize'

class FileReader
  attr_reader :err_msg, :file_lines, :file_path, :file_lines_count
  def initialize(file_path)
    @err_msg = ''
    @file_path = file_path
    begin
      @file_lines = File.readlines(@file_path)
      @file_lines_count = @file_lines.size
    rescue
      @file_lines = []
      @err_msg = "PLEASE CHECK YOUR PATH AND FILE!\n".colorize(:light_red) + e.to_s.colorize(:red)
    end
  end
end

