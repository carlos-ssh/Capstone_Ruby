require_relative '../lib/check.rb'

describe CheckError do
  let(:checker) { CheckError.new('../bugs/bug.rb') }

  describe '#tag_error' do
    it "returns missing/unexpected tags eg '( )', '[ ]', and '{ }'" do
      checker.tag_error
      expect(checker.errors[0]) == ("line:3 Lint/Syntax: Unexpected/Missing token ']' Square Bracket")
    end
  end

  describe '#end_error' do
    it 'returns missing/unexpected end' do
      checker.end_error
      expect(checker.errors[0]) == ("Lint/Syntax: Missing 'end'")
    end
  end

  describe '#empty_line_error' do
    it 'returns empty line error' do
      checker.empty_line_error
      expect(checker.errors[0]) == ('line:11 Extra empty line detected at block body end')
    end
  end
end
