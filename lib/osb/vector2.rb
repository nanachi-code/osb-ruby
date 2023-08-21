# frozen_string_literal: true

module Osb
  # Represents a 2d point or vector.
  class Vector2
    attr_accessor :x, :y
    # @!attribute [rw] x
    #   @return x coordinate of this vector
    # @!attribute [rw] y
    #   @return y coordinate of this vector

    # @param [Numeric, Array<Numeric>] x
    #   x coordinate of this +{Vector2}+, or an +Array+ of 2 numbers.
    # @param [Numeric] y y coordinate of this +{Vector2}+
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

    # Add another +{Vector2}+ to this one.
    # @param [Vector2] vector
    # @return [Vector2]
    def +(vector)
      Internal.assert_type!(vector, Vector2, "vector")
      Vector2.new(self.x + vector.x, self.y + vector.y)
    end

    # Subtract another +{Vector2}+ from this one.
    # @param [Vector2] vector
    # @return [Vector2]
    def -(vector)
      Internal.assert_type!(vector, Vector2, "vector")
      Vector2.new(self.x - vector.x, self.y - vector.y)
    end

    # Returns whether two +{Vector2}+ are equal within tolerance
    # @param [Vector2] vector
    # @return [Boolean]
    def ==(vector)
      Internal.assert_type!(vector, Vector2, "vector")
      Math.fuzzy_equal(self.x, vector.x) && Math.fuzzy_equal(self.y, vector.y)
    end

    # Returns whether two +{Vector2}+ are not equal within tolerance
    # @param [Vector2] vector
    # @return [Boolean]
    def !=(vector)
      !(self == vector)
    end

    # Makes a copy of this +{Vector2}+.
    # @return [Vector2]
    def clone
      Vector2.new(self.x, self.y)
    end

    # Retrieves the coordinates in an Array.
    # @return [Array(Float, Float)]
    def to_a
      [self.x, self.y]
    end

    # Returns a string representation of this +{Vector2}+.
    # @return [String]
    def to_s
      self.to_a.to_s
    end

    # Returns the length of this +{Vector2}+.
    # @return [Float]
    def length
      Math.sqrt(self.x**2 + self.y**2)
    end
  end

  # Create a +{Vector2}+.
  # @param [Numeric, Array<Numeric>] x
  #   x coordinate of this +{Vector2}+, or an +Array+ of 2 numbers.
  # @param [Numeric] y y coordinate of this +{Vector2}+
  def vec2(x = 0, y = 0)
    Vector2.new(x, y)
  end
end
