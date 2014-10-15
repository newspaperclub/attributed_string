require 'spec_helper'

describe AttributedString do
  let(:string) { "Hello brave new world" }
  let(:attributes) do
    [
      AttributedString::Attribute.new(Range.new(0, 5), { weight: :bold }),
      AttributedString::Attribute.new(Range.new(6, 11), { weight: :bold }),
    ]
  end

  let(:alt_string) { "Testing" }
  let(:alt_attributes) do
    [
      AttributedString::Attribute.new(Range.new(0, 7), { style: :italic }),
    ]
  end
  let(:alt_attributed_string) { AttributedString.new(alt_string.dup, alt_attributes.dup) }

  subject { AttributedString.new(string.dup, attributes.dup) }

  it "should have a length of 21" do
    expect(subject.length).to eq(21)
  end

  it "should have the correct attributes" do
    expect(subject.attributes).to eq(attributes)
  end

  it "should have the correct string" do
    expect(subject.string).to eq("Hello brave new world")
  end

  describe 'appending an AttributedString' do
    before do
      subject << alt_attributed_string
    end

    it "should have the right length" do
      expect(subject.length).to eq(28)
    end

    it "should have a concatenated string" do
      expect(subject.string).to eq("Hello brave new worldTesting")
    end

    it "should have 3 attributes" do
      expect(subject.attributes.length).to eq(3)
    end
  end

  describe 'prepending an AttributedString' do
    before do
      subject.prepend(alt_attributed_string)
    end

    it "should have the right length" do
      expect(subject.length).to eq(28)
    end

    it "should have a concatenated string" do
      expect(subject.string).to eq("TestingHello brave new world")
    end

    it "should have 3 attributes" do
      expect(subject.attributes.length).to eq(3)
    end

    it "the first and second attributes should have moved up" do
      expect(subject.attributes[0].range).to eq(Range.new(7, 12))
      expect(subject.attributes[1].range).to eq(Range.new(13, 18))
    end

    it "the third attribute should be at the beginning" do
      expect(subject.attributes[2].range).to eq(Range.new(0, 7))
    end
  end

  describe '.fix' do
    before do
      subject.fix
    end

    context 'with non-overlapping attributes' do
      it "preserves the attributes" do
        expect(subject.attributes).to eq(attributes)
      end
    end

    context 'with two overlapping attributes' do
      let(:attributes) do
        [
          AttributedString::Attribute.new(Range.new(0, 8), { weight: :bold }),
          AttributedString::Attribute.new(Range.new(6, 11), { weight: :bold }),
        ]
      end

      it "reduces to 1 attribute" do
        expect(subject.attributes.length).to eq(1)
      end

      it "has the right data" do
        expect(subject.attributes.first.data).to eq({ weight: :bold })
      end

      it "has the right range" do
        expect(subject.attributes.first.range).to eq(Range.new(0, 11))
      end
    end

    context 'with two touching attributes' do
      let(:attributes) do
        [
          AttributedString::Attribute.new(Range.new(0, 8), { weight: :bold }),
          AttributedString::Attribute.new(Range.new(8, 11), { weight: :bold }),
        ]
      end

      it "reduces to 1 attribute" do
        expect(subject.attributes.length).to eq(1)
      end

      it "has the right data" do
        expect(subject.attributes.first.data).to eq({ weight: :bold })
      end

      it "has the right range" do
        expect(subject.attributes.first.range).to eq(Range.new(0, 11))
      end
    end

    context 'with two overlapping attributes in reverse order' do
      let(:attributes) do
        [
          AttributedString::Attribute.new(Range.new(6, 11), { weight: :bold }),
          AttributedString::Attribute.new(Range.new(0, 8), { weight: :bold }),
        ]
      end

      it "reduces to 1 attribute" do
        expect(subject.attributes.length).to eq(1)
      end

      it "has the right data" do
        expect(subject.attributes.first.data).to eq({ weight: :bold })
      end

      it "has the right range" do
        expect(subject.attributes.first.range).to eq(Range.new(0, 11))
      end
    end

    context 'with three overlapping attributes' do
      let(:attributes) do
        [
          AttributedString::Attribute.new(Range.new(0, 8), { weight: :bold }),
          AttributedString::Attribute.new(Range.new(6, 11), { weight: :bold }),
          AttributedString::Attribute.new(Range.new(10, 11), { weight: :bold }),
        ]
      end

      it "reduces to 1 attribute" do
        expect(subject.attributes.length).to eq(1)
      end

      it "has the right data" do
        expect(subject.attributes.first.data).to eq({ weight: :bold })
      end

      it "has the right range" do
        expect(subject.attributes.first.range).to eq(Range.new(0, 11))
      end
    end

    context 'with three attributes, two of which are the same' do
      let(:attributes) do
        [
          AttributedString::Attribute.new(Range.new(0, 8), { weight: :bold }),
          AttributedString::Attribute.new(Range.new(6, 13), { style: :italic }),
          AttributedString::Attribute.new(Range.new(8, 11), { weight: :bold }),
        ]
      end

      it "reduces to 2 attributes" do
        expect(subject.attributes.length).to eq(2)
      end

      it "has the right data for the first" do
        expect(subject.attributes.first.data).to eq({ weight: :bold })
      end

      it "has the right range for the first" do
        expect(subject.attributes.first.range).to eq(Range.new(0, 11))
      end

      it "has the right data for the second" do
        expect(subject.attributes[1].data).to eq({ style: :italic })
      end

      it "has the right range for the first" do
        expect(subject.attributes[1].range).to eq(Range.new(6, 13))
      end
    end
  end
end
