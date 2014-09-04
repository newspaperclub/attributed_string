class AttributedString
  class Attribute

    attr_reader :range, :data

    def initialize(range, data)
      @range = range
      @data = data
    end

    def move(offset)
      @range = Range.new(@range.begin + offset, @range.end + offset, @range.exclude_end?)
    end

  end
end
