require 'attributed_string/version'
require 'attributed_string/attribute'

class AttributedString

  attr_reader :string, :attributes

  def initialize(string, attributes = [])
    @string     = string
    @attributes = attributes
  end

  def <<(attributed_string)
    @string << attributed_string.string
    @attributes += attributed_string.attributes
  end

  def prepend(attributed_string)
    @string.prepend(attributed_string.string)
    move_attributes(attributed_string.length)
    @attributes += attributed_string.attributes
  end

  def length
    @string.length
  end

  def fix
    # Group into identical data structures
    grouped_attributes = @attributes.group_by { |a| a.data }.values

    # Sort each group into order
    grouped_attributes.each do |group|
      group.sort_by! { |a| a.range.begin }
    end

    # Merge attributes in identical groups together
    merged_attributes = grouped_attributes.map do |group|
      group.inject([]) do |attrs, a|
        if !attrs.empty? && attributes_overlap?(attrs.last, a)
          attrs[0...-1] + [merge_attributes(attrs.last, a)]
        else
          attrs + [a]
        end
      end
    end

    @attributes = merged_attributes.flatten
  end

  private

  def move_attributes(offset)
    @attributes.each do |attribute|
      attribute.move(offset)
    end
  end

  def attributes_overlap?(a, b)
    a.data == b.data && (a.range.include?(b.range.begin) || b.range.include?(a.range.begin))
  end

  def merge_attributes(a, b)
    range = [a.range.begin, b.range.begin].min..[a.range.end, b.range.end].max
    AttributedString::Attribute.new(range, a.data)
  end

end
