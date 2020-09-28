require 'colorize'
require 'strscan'
require_relative 'file_reader.rb'

class CheckError
  attr_reader :errors, :checker

  def initialize(file_path)
    @errors = []
    @checker = FileReader.new(file_path)

    @keywords = %w[module unless do if case class begin]
  end

  def tag_error
    check_tag_error(/\(/, /\)/, '(', ')', 'Parentheses')
    check_tag_error(/\[/, /\]/, '[', ']', 'Square_Brackets')
    check_tag_error(/\{/, /\}/, '{', '}', 'Curly_Brackets')  
  end
  
  def check_trailing_spaces
    @checker.file_lines.each_with_index do |str_val, index|
      if str_val[-2] == ' ' && !str_val.strip.empty?
        @errors << "line: #{index + 1}: #{str_val.size - 1}: Error: Whitespace detected."
        + " '#{str_val.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def end_error
    keyw_count = 0
    end_count = 0

    @checker.file_lines.each_with_index do |str_val, _index|
      keyw_count += 1 if keywords.include?(str_val.split(' ').first) && str_val.split(' ').include?('do')
      end_count += 1 if str_val.strip == 'end'
    end

    status = keyw_count <=> end_count
    log_error("Lint/Syntax Error: Missing 'end'") if status.eql?(1)
    log_error("Lint/Syntax Error: Unexpected 'end'") if status.eql?(-1)
  end

