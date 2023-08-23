# frozen_string_literal: true

# A number of methods have been added to the Ruby Integer class to do units conversions.
class Integer
  # Does nothing. Just a way to tell people it's represented in milliseconds.
  # @return [Integer]
  def ms
    self
  end

  # Convert from seconds to milliseconds.
  # @return [Integer]
  def second
    self * 1000
  end

  # Convert from percentage to float.
  # @return [Float]
  def percent
    self / 100.0
  end
end
