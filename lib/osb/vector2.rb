# frozen_string_literal: true

module Osb
  # Represents a 2d point or vector.
  class Vector2
    # @return [Numeric] x coordinate of this vector
    attr_accessor :x
    # @return [Numeric] y coordinate of this vector
    attr_accessor :y

    # @param [Numeric, Array<Numeric>] x
    #   x coordinate of this vector, or an +Array+ of 2 {Numeric} values.
    # @param [Numeric] y y coordinate of this vector
    def initialize(x = 0, y = 0)
      Internal.assert_type!(x, [Numeric, Internal::T[Array][Numeric]], "x")
      Internal.assert_type!(y, Numeric, "y")

      if x.is_a?(Array)
        if x.size != 2
          raise InvalidValueError, "Must be an Array of 2 Numeric values."
        end
        @x = x[0]
        @y = x[1]
      else
        @x = x
        @y = y
      end
    end

    # Add another 2d vector to this one.
    # @param [Vector2] vector
    # @return [Vector2]
    def +(vector)
      Internal.assert_type!(vector, Vector2, "vector")
      Vector2.new(self.x + vector.x, self.y + vector.y)
    end

    # Subtract another 2d vector from this one.
    # @param [Vector2] vector
    # @return [Vector2]
    def -(vector)
      Internal.assert_type!(vector, Vector2, "vector")
      Vector2.new(self.x - vector.x, self.y - vector.y)
    end

    # Returns whether two 2d vector are equal within tolerance
    # @param [Vector2] vector
    # @return [Boolean]
    def ==(vector)
      Internal.assert_type!(vector, Vector2, "vector")
      Math.fuzzy_equal(self.x, vector.x) && Math.fuzzy_equal(self.y, vector.y)
    end

    # Returns whether two 2d vector are not equal within tolerance
    # @param [Vector2] vector
    # @return [Boolean]
    def !=(vector)
      !(self == vector)
    end

    # Makes a copy of this 2d vector.
    # @return [Vector2]
    def clone
      Vector2.new(self.x, self.y)
    end

    # Retrieves the coordinates in an Array.
    # @return [Array(Float, Float)]
    def to_a
      [self.x, self.y]
    end

    # Returns a string representation of this 2d vector.
    # @return [String]
    def to_s
      self.to_a.to_s
    end

    # Returns the length of this 2d vector.
    # @return [Float]
    def length
      Math.sqrt(self.x**2 + self.y**2)
    end
  end

  # Create a 2d vector.
  # @param [Numeric, Array<Numeric>] x
  #   x coordinate of this 2d vector, or an +Array+ of 2 numbers.
  # @param [Numeric] y y coordinate of this 2d vector
  # @return [Vector2]
  def vec2(x = 0, y = 0)
    Vector2.new(x, y)
  end
end
