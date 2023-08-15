# Represents a 2d point or vector.
class Vector2
  attr_accessor :x, :y
  # @!attribute [rw] x
  #  @return x coordinate of this vector
  # @!attribute [rw] y
  #  @return y coordinate of this vector

  # @param [Float, Integer] x
  # @param [Float, Integer] y
  def initialize(x, y)
    Internal.assert_type!(x, [Float, Integer], 'x')
    Internal.assert_type!(x, [Float, Integer], 'y')
  end
end

# Alias for creating new Vector2.
# @param [Float, Integer] x
# @param [Float, Integer] y
def self.vec2(x, y)
  Vector2.new(x, y)
end