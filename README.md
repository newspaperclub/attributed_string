# attributed_string

Similar to a `NSAttributedString` in Objective-C, this provides an `AttributedString` class. It's similar to a normal `String`, but tracks an array of `AttributedString::Attribute` instances, each of which references a range and a blob of data about that range.

This is useful for storing string formatting information separately from the plain text, while still being about to do transforms like prepend and append operations.

## Example

```ruby
string    = "This is a test"
range     = Range.new(0, 3)
data      = { weight: :bold }
# This marks the first word as being bold. The implementation of the data is up to you, but here we use a simple Hash.
attribute = AttributedString::Attribute.new(range, data)

attributed_string = AttributedString.new(string, [attribute])

# This prepends another AttributedString, but keeps track of the position of the original attributes.
attributed_string.prepend(another_attributed_string)

# Coalesces overlapping attributes of identical data
attributed_string.fix
```
