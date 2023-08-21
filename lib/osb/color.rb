# frozen_string_literal: true

module Osb
  # Represents an RGB color.
  class Color
    attr_accessor :r, :g, :b
    # @attribute [rw] r
    #   @return Red value.
    # @attribute [rw] g
    #   @return Green value.
    # @attribute [rw] b
    #   @return Blue value.

    # @param [Integer, String, Array<Integer>] r red value, a hex +String+, 
    #   or an +Array+ of 3 +{Integer}+s.
    # @param [Integer] g green value
    # @param [Integer] b blue value
    def initialize(r, g = nil, b = nil)
      Internal.assert_type!(
        r,
        [Integer, String, Internal::T[Array][Integer]],
        "r"
      )
      if r.is_a?(Array)
        if r.size != 3
          raise InvalidValueError, "Must be an Array of 3 Integers."
        end
        @r = r[0]
        @g = r[1]
        @b = r[2]
      elsif r.is_a?(String)
        Color.from_hex(r)
      else
        Internal.assert_value!(r, 0..255, "r")

        Internal.assert_type!(g, Integer, "g")
        Internal.assert_value!(g, 0..255, "g")

        Internal.assert_type!(b, Integer, "b")
        Internal.assert_value!(b, 0..255, "b")

        @r = r
        @g = g
        @b = b
      end
    end

    # Returns whether 2 colors are not equal.
    # @param [Color] color
    def !=(color)
      Internal.assert_type!(color, Color, "color")

      color.r != self.r && color.g != self.g && color.b != self.b
    end

    # Converts an HSL color value to RGB.
    # @param [Integer] hue
    # @param [Integer] saturation
    # @param [Integer] lightness
    # @return [Color]
    def self.from_hsl(h, s, l)
      Internal.assert_type!(h, Integer, "h")
      Internal.assert_type!(s, Integer, "s")
      Internal.assert_type!(l, Integer, "l")

      h = h / 360.0
      s = s / 100.0
      l = l / 100.0

      r = 0.0
      g = 0.0
      b = 0.0

      if s == 0.0
        r = l.to_f
        g = l.to_f
        b = l.to_f
      else
        q = l < 0.5 ? l * (1 + s) : l + s - l * s
        p = 2 * l - q
        r = hue_to_rgb(p, q, h + 1 / 3.0)
        g = hue_to_rgb(p, q, h)
        b = hue_to_rgb(p, q, h - 1 / 3.0)
      end

      Color.new((r * 255).round, (g * 255).round, (b * 255).round)
    end

    # @private
    # @param [Float] p
    # @param [Float] q
    # @param [Float] t_
    # @return [Float]
    def self.hue_to_rgb(p, q, t_)
      t = t_ + 1 if t_ < 0
      t = t_ - 1 if t_ > 1
      return(p + (q - p) * 6 * t) if t < 1 / 6.0
      return q if t < 1 / 2.0
      return(p + (q - p) * (2 / 3.0 - t) * 6) if t < 2 / 3.0
      return p
    end

    # Create a +{Color}+ object from hex string.
    # @param [String] hex
    # @return [Color]
    def self.from_hex(hex)
      Internal.assert_type!(hex, String, "hex")

      hex.gsub!("#", "")
      components = hex.scan(/.{2}/)
      components.collect { |component| component.to_i(16) }
    end
  end

  # Create a new rgb +{Color}+.
  # @param [Integer, String, Array<Integer>] r red value, a hex +String+, 
  #   or an +Array+ of 3 +{Integer}+s.
  # @param [Integer] g green value
  # @param [Integer] b blue value
  # @return [Color]
  def rgb(r, g = nil, b = nil)
    Color.new(r, g, b)
  end

  # Create a new hsl +{Color}+.
  # @param [Integer] hue
  # @param [Integer] saturation
  # @param [Integer] lightness
  # @return [Color]
  def hsl(h, s, l)
    Color.from_hsl(h, s, l)
  end
end
