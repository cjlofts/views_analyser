require_relative '../lib/parser'
RSpec.describe Parser do

  describe 'parse' do
    context 'when the file is correctly formatted' do
      let(:instance) { described_class.new('spec/fixtures/correct_format.txt') }

      it 'is able to parse the file' do
        expect(instance.parse).to be_truthy
      end

      it 'returns the expected object' do
        expect(instance.parse.class).to eq(Hash)
      end

      it 'has the correct keys for each item' do
        return_value = instance.parse
        correct_keys = return_value.all? do |_, value|
          value.key?('count') && value.key?('unique_ips')
        end

        expect(correct_keys).to eq(true)
      end

      it 'has the correct type for the count' do
        return_value = instance.parse
        correct_count_type = return_value.all? do |_, value|
          value['count'].is_a?(Integer)
        end

        expect(correct_count_type).to eq(true)
      end

      it 'has the correct type for the count' do
        return_value = instance.parse
        correct_unique_type = return_value.all? do |_, value|
          value['unique_ips'].is_a?(Set)
        end

        expect(correct_unique_type).to eq(true)
      end
    end

    context 'when the file is incorrectly formatted' do
      let(:instance) { described_class.new('spec/fixtures/incorrect_format.txt') }

      it 'raises the expected error indicating a change in format' do
        expect{ instance.parse }.to raise_error(Parser::FileFormatError)
      end
    end
  end
end
