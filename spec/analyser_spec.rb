require_relative '../lib/analyser'
RSpec.describe Analyser do

  describe 'page_views' do
    context 'when the file is correctly formatted' do
      let(:instance) { described_class.new('spec/fixtures/correct_format.txt') }

      it 'is able to parse the file' do
        expect(instance.page_views).to be_truthy
      end

      it 'returns the expected value' do
        expect(instance.page_views).to eq(:page_views_descending)
      end
    end

    context 'when the file is incorrectly formatted' do
      let(:instance) { described_class.new('spec/fixtures/incorrect_format.txt') }

      it 'returns the expected error' do
        expect{ instance.page_views }.to raise_error(Parser::FileFormatError)
      end
    end
  end

  describe 'unique_views' do
    context 'when the file is correctly formatted' do
      let(:instance) { described_class.new('spec/fixtures/correct_format.txt') }

      it 'is able to parse the file' do
        expect(instance.unique_views).to be_truthy
      end

      it 'returns the expected value' do
        expect(instance.unique_views).to eq(:unique_views_descending)
      end
    end

    context 'when the file is incorrectly formatted' do
      let(:instance) { described_class.new('spec/fixtures/incorrect_format.txt') }

      it 'returns the expected error' do
        expect{ instance.unique_views }.to raise_error(Parser::FileFormatError)
      end
    end
  end
end
