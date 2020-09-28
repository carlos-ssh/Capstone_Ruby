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



end
