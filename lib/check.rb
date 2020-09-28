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

  def empty_line_error
    @checker.file_lines.each_with_index do |str_val, indx|
      check_class_empty_line(str_val, indx)
      check_do_empty_line(str_val, indx)
      check_end_empty_line(str_val, indx)
      check_def_empty_line(str_val, indx)
    end
  end
  
  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def check_identation
    msg = "Identation Error: Use two spaces or more"
    cur_val = 0
    indent_val = 0

    @checker.file_lines.each_with_index do |str_val, indx|
      strip_line = str_val.strip.split(' ')
      exp_val = cur_val * 2

      res_words = %w[begin case module unless until elsif def if class]

      next unless !str_val.strip.empty? || !strip_line.first.eql?('#')
      
      indent_val += 1 if res_word.include?(strip_line.first) || strip_line.include?('do')
      indent_val += 1 if str_val.strip == 'end'
    end
  end
