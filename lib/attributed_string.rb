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

  private

  def move_attributes(offset)
    @attributes.each do |attribute|
      attribute.move(offset)
    end
  end

end
