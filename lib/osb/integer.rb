class Integer
  def ms
    self
  end

  # Convert from seconds to milliseconds.
  def second
    self * 1000
  end

  # Convert from percentage to float.
  def percent
    self / 100.0
  end
end
