require_relative '../lib/checks.rb'

describe CheckError do
  let(:checker) { CheckError.new('bug.rb') }

  describe '#empty_line_error' do
    it 'returns empty line error' do
      checker.empty_line_error
      expect(checker.errors[0]).to eql('line:11 Extra empty line detected at block body end')
    end
  end

  describe '#end_error' do
    it 'returns missing/unexpected end' do
      checker.end_error
      expect(checker.errors[0]).to eql("Lint/Syntax: Missing 'end'")
    end
  end
end
