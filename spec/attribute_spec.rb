require 'spec_helper'

describe AttributedString::Attribute do
  let(:range) { Range.new(0, 5) }
  let(:data) { { foo: :bar } }
  subject { AttributedString::Attribute.new(range, data) }

  describe '.move' do
    before { subject.move(3) }

    it "moves the range up" do
      expect(subject.range).to eq(Range.new(3, 8))
    end
  end
end
