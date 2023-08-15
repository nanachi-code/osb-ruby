module Internal
  # @param [Integer] time
  def self.assert_start_time!(time)
    Internal.assert_type!(time, Integer, "start_time")
  end

  # @param [Integer] time
  def self.assert_end_time!(time)
    Internal.assert_type!(time, Integer, "end_time")
  end

  # @param [Integer] easing
  def self.assert_easing!(easing)
    Internal.assert_type!(easing, Integer, "easing")
    Internal.assert_value!(easing, Easing::ALL, "easing")
  end

  module Commandable
    # Change the opacity of the object (how transparent it is).
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Float] start_opacity
    # @param [Float, nil] end_opacity
    def fade(
      start_time:,
      end_time: nil,
      easing: Easing::Linear,
      start_opacity:,
      end_opacity: nil
    )
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_opacity, [Float, Integer], "start_opacity")
      if end_opacity
        Internal.assert_type!(end_opacity, [Float, Integer], "end_opacity")
      end
      Internal.assert_value!(start_opacity, 0..1, "start_opacity")
      Internal.assert_value!(end_opacity, 0..1, "end_opacity") if end_opacity

      end_time_ = "" if !end_time || start_time == end_time
      command = " F,#{start_time},#{end_time},#{start_opacity}"
      command += ",#{end_opacity}" if end_opacity
      @commands << command
    end

    # Move the object to a new position in the play area.
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Vector2] start_position
    # @param [Vector2, nil] end_position
    def move(
      start_time:,
      end_time: nil,
      easing: Easing::Linear,
      start_position:,
      end_position: nil
    )
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_position, Vector2, "start_position")
      if end_position
        Internal.assert_type!(end_position, Vector2, "end_position")
      end

      end_time_ = "" if !end_time || start_time == end_time
      command =
        " M,#{start_time},#{end_time},#{start_position.x},#{start_position.y}"
      command += ",#{end_position.x},#{end_position.y}" if end_position
      @commands << command
    end

    # Move the object along the x axis.
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Float, Integer] start_x
    # @param [Float, Integer, nil] end_x
    def move_x(start_time:, end_time: nil, easing:, start_x:, end_x: nil)
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_x, [Float, Integer], "start_x")
      Internal.assert_type!(end_x, [Float, Integer], "end_x") if end_x

      end_time_ = "" if !end_time || start_time == end_time
      command = " MX,#{start_time},#{end_time},#{start_x}"
      command += ",#{end_x}" if end_x
      @commands << command
    end

    # Move the object along the y axis.
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Float, Integer] start_y
    # @param [Float, Integer, nil] end_y
    def move_y(start_time:, end_time: nil, easing:, start_y:, end_y: nil)
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_y, [Float, Integer], "start_y")
      Internal.assert_type!(end_y, [Float, Integer], "end_y") if end_y

      end_time_ = "" if !end_time || start_time == end_time
      command = " MY,#{start_time},#{end_time},#{start_y}"
      command += ",#{end_y}" if end_y
      @commands << command
    end

    # Change the size of the object relative to its original size.
    # The scaling is affected by the object's origin
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Float, Integer] start_scale
    # @param [Float, Integer, nil] end_scale
    def scale(start_time:, end_time: nil, easing:, start_scale:, end_scale: nil)
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_scale, [Float, Integer], "start_scale")
      if end_scale
        Internal.assert_type!(end_scale, [Float, Integer], "end_scale")
      end

      end_time_ = "" if !end_time || start_time == end_time
      command = " S,#{start_time},#{end_time},#{start_scale}"
      command += ",#{end_scale}" if end_scale
      @commands << command
    end

    # Change the size of the object relative to its original size. X and Y scale seperately.
    # The scaling is affected by the object's origin.
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Vector2] start_scale
    # @param [Vector2, nil] end_scale
    def vector_scale(
      start_time:,
      end_time: nil,
      easing: Easing::Linear,
      start_position:,
      end_scale: nil
    )
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_scale, Vector2, "start_scale")
      Internal.assert_type!(end_scale, Vector2, "end_scale") if end_scale

      end_time_ = "" if !end_time || start_time == end_time
      command = " V,#{start_time},#{end_time},#{start_scale.x},#{start_scale.y}"
      command += ",#{end_scale.x},#{end_scale.y}" if end_scale
      @commands << command
    end

    # Rotate the object around its origin.
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Float] start_rotate
    # @param [Float, nil] end_rotate
    def rotate(
      start_time:,
      end_time: nil,
      easing: Easing::Linear,
      start_rotate:,
      end_rotate: nil
    )
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_rotate, [Float, Integer], "start_rotate")
      if end_rotate
        Internal.assert_type!(end_rotate, [Float, Integer], "end_rotate")
      end

      end_time_ = "" if !end_time || start_time == end_time
      command = " R,#{start_time},#{end_time},#{start_rotate}"
      command += ",#{end_rotate}" if end_rotate
      @commands << command
    end

    # The virtual light source colour on the object. The colours of the pixels on the object are determined subtractively.
    # @param [Integer] start_time
    # @param [Integer, nil] end_time
    # @param [Integer] easing
    # @param [Color] start_color
    # @param [Color, nil] end_color
    def color(
      start_time:,
      end_time: nil,
      easing: Easing::Linear,
      start_color:,
      end_color: nil
    )
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time) if end_time
      Internal.assert_easing!(easing)
      Internal.assert_type!(start_color, Color, "start_color")
      Internal.assert_type!(end_color, Color, "end_color") if end_color

      end_time_ = "" if !end_time || start_time == end_time
      command =
        " C,#{start_time},#{end_time},#{start_color.r},#{start_color.g},#{start_color.b}"
      command += ",#{end_color.r},#{end_color.g},#{end_color.b}" if end_color
      @commands << command
    end

    # Flip the object horizontally or vertically.
    # @param [Integer] start_time
    # @param [Integer] end_time
    # @param [Boolean] horizontally
    # @param [Boolean] vertically
    def flip(start_time:, end_time:, horizontally: true, vertically: false)
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time)
      Internal.assert_type!(horizontally, Internal::Boolean, "horizontally")
      Internal.assert_type!(vertically, Internal::Boolean, "vertically")

      if horizontally && vertically
        raise ArgumentError,
              "Cannot flip an object both horizontally and vertically"
      end

      direction = horizontally ? "H" : "V"
      end_time_ = "" if !end_time || start_time == end_time
      command = " P,#{start_time},#{end_time},#{direction}"
      @commands << command
    end

    # Use additive-colour blending instead of alpha-blending
    # @param [Integer] start_time
    # @param [Integer] end_time
    def additive_color_blending(start_time:, end_time:)
      Internal.assert_start_time!(start_time)
      Internal.assert_end_time!(end_time)

      command = " P,#{start_time},#{end_time},A"
      @commands << command
    end
  end
end
