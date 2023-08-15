module Math
  # Absolute threshold to be used for comparing reals generally.
  REAL_THRESHOLD = 1e-8

  # Returns whether 2 real numbers are equal within tolerance.
  # @param [Float] x 
  # @param [Float] y 
  # @param [Numeric] tolerance
  # @return [Boolean]
  def self.fuzzy_equal(x, y, tolerance = REAL_THRESHOLD)
    (x - y).abs < epsilon
  end
end