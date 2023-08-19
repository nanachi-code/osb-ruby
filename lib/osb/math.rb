# frozen_string_literal: true

module Math
  # Returns whether 2 real numbers are equal within tolerance.
  # @param [Float] x
  # @param [Float] y
  # @param [Numeric] tolerance
  # @return [Boolean]
  def self.fuzzy_equal(x, y, tolerance = 1e-8)
    (x - y).abs < tolerance
  end
end
