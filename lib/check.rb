require 'colorize'
require 'strscan'
require_relative 'file_reader.rb'

class CheckError
  attr_reader :checker, :errors

  def initialize(file_path)
    @checker = FileReader.new(file_path)
    @errors = []
    @keywords = %w[begin case class def do if module unless]
  end

  def check_trailing_spaces
    @checker.file_lines.each_with_index do |str_val, index|
      if str_val[-2] == ' ' && !str_val.strip.empty?
        @errors << "line:#{index + 1}:#{str_val.size - 1}: Error: Trailing whitespace detected."
        + " '#{str_val.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def tag_error
    check_tag_error(/\(/, /\)/, '(', ')', 'Parenthesis')
    check_tag_error(/\[/, /\]/, '[', ']', 'Square Bracket')
    check_tag_error(/\{/, /\}/, '{', '}', 'Curly Bracket')
  end

  def end_error
    keyw_count = 0
    end_count = 0
    @checker.file_lines.each_with_index do |str_val, _index|
      keyw_count += 1 if @keywords.include?(str_val.split(' ').first) || str_val.split(' ').include?('do')
      end_count += 1 if str_val.strip == 'end'
    end

    status = keyw_count <=> end_count
    log_error("Lint/Syntax: Missing 'end'") if status.eql?(1)
    log_error("Lint/Syntax: Unexpected 'end'") if status.eql?(-1)
  end

  def empty_line_error
    @checker.file_lines.each_with_index do |str_val, indx|
      check_class_empty_line(str_val, indx)
      check_def_empty_line(str_val, indx)
      check_end_empty_line(str_val, indx)
      check_do_empty_line(str_val, indx)
    end
  end
  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def check_indentation
    msg = 'Indentation Width: Use 2 spaces for indentation.'
    cur_val = 0
    indent_val = 0

    @checker.file_lines.each_with_index do |str_val, indx|
      res_word = %w[class def if elsif until module unless begin case]
      str_val = str_val.strip
      strip_line = str_val.split(' ')
      exp_val = cur_val * 2

      next unless !str_val.empty? || !strip_line.first.eql?('#')

      indent_val += 1 if res_word.include?(strip_line.first) || strip_line.include?('do')
      indent_val -= 1 if str_val == 'end'
      next unless str_val.empty?

      cur_val = indent_val
      indent_error(str_val, indx, exp_val, msg)
    end
  end

  private

  def indent_error(str_val, indx, exp_val, msg)
    str_val = str_val.strip
    strip_line = str_val.split(' ').first
    emp = str_val.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)

    if str_val.eql?('end') || strip_line == 'elsif' || strip_line == 'when' || !end_chk
      log_error("line:#{indx + 1} #{msg}")
    elsif !emp[0].size.eql?(exp_val)
      log_error("line:#{indx + 1} #{msg}")
    end
  end

  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def check_tag_error(*args)
    @checker.file_lines.each_with_index do |str_val, index|
      open_p = []
      close_p = []
      open_p << str_val.scan(args[0])
      close_p << str_val.scan(args[1])

      status = open_p.flatten.size <=> close_p.flatten.size

      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if status.eql?(1)
      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if status.eql?(-1)
    end
  end

  def check_class_empty_line(str_val, indx)
    msg = 'Extra empty line detected at class body beginning'
    return unless str_val.strip.split(' ').first.eql?('class')

    log_error("line:#{indx + 2} #{msg}") if @checker.file_lines[indx + 1].strip.empty?
  end

  def check_def_empty_line(str_val, indx)
    msg1 = 'Extra empty line detected at method body beginning'
    msg2 = 'Use empty lines between method definition'

    return unless str_val.strip.split(' ').first.eql?('def')

    log_error("line:#{indx + 2} #{msg1}") if @checker.file_lines[indx + 1].strip.empty?
    log_error("line:#{indx + 1} #{msg2}") if @checker.file_lines[indx - 1].strip.split(' ').first.eql?('end')
  end

  def check_end_empty_line(str_val, indx)
    return unless str_val.strip.split(' ').first.eql?('end')

    log_error("line:#{indx} Extra empty line detected at block body end") if @checker.file_lines[indx - 1].strip.empty?
  end

  def check_do_empty_line(str_val, indx)
    msg = 'Extra empty line detected at block body beginning'
    return unless str_val.strip.split(' ').include?('do')

    log_error("line:#{indx + 2} #{msg}") if @checker.file_lines[indx + 1].strip.empty?
  end

  def log_error(error_msg)
    @errors << error_msg
  end
end
