# frozen_string_literal: true

class Numeric
  # The degrees method is used to convert from degrees to radians.
  # @return [Float]
  def degrees
    self * Math::PI / 180
  end
end
