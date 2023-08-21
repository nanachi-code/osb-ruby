module Osb
  # @private
  def current_object
    return @sprite if @sprite
    return @animation if @animation
    return nil
  end

  # @private
  def raise_unless_inside_object!
    self.raise_unless_inside_storyboard!
    unless self.current_object
      raise RuntimeError,
            "Do not call this method outside of a sprite/animation context."
    end
  end

  # Change the opacity of the object (how transparent it is).
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Numeric] start_opacity
  # @param [Numeric] end_opacity
  # @return [void]
  def fade(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_opacity:,
    end_opacity: start_opacity
  )
    self.raise_unless_inside_object!
    self.current_object.fade(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_opacity: start_opacity,
      end_opacity: end_opacity
    )
  end

  # Move the object to a new position in the play area.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Osb::Vector2, Array<Numeric>] start_position
  # @param [Osb::Vector2, Array<Numeric>] end_position
  # @return [void]
  def move(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_position:,
    end_position: start_position
  )
    self.raise_unless_inside_object!
    self.current_object.move(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_position: start_position,
      end_position: end_position
    )
  end

  # Move the object along the x axis.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Numeric] start_x
  # @param [Numeric] end_x
  # @return [void]
  def move_x(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_x:,
    end_x: start_x
  )
    self.raise_unless_inside_object!
    self.current_object.move_x(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_x: start_x,
      end_x: end_x
    )
  end

  # Move the object along the y axis.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Numeric] start_y
  # @param [Numeric] end_y
  # @return [void]
  def move_y(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_y:,
    end_y: start_y
  )
    self.raise_unless_inside_object!
    self.current_object.move_x(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_y: start_y,
      end_y: end_y
    )
  end

  # Change the size of the object relative to its original size. Will scale
  # seperatedly if given +Osb::Vector2+s or +Array<Numeric>+s. The scaling is
  # affected by the object's origin
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Numeric, Osb::Vector2, Array<Numeric>] start_scale
  # @param [Numeric, Osb::Vector2, Array<Numeric>] end_scale
  # @return [void]
  def scale(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_scale:,
    end_scale: start_scale
  )
    self.raise_unless_inside_object!
    self.current_object.scale(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_scale: start_scale,
      end_scale: end_scale
    )
  end

  # Rotate the object around its origin.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Float] start_angle start angle in radians.
  # @param [Float] end_angle end angle in radians.
  # @return [void]
  def rotate(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_angle:,
    end_angle: start_angle
  )
    self.raise_unless_inside_object!
    self.current_object.rotate(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_angle: start_angle,
      end_angle: end_angle
    )
  end

  # The virtual light source colour on the object. The colours of the pixels on the object are determined subtractively.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Integer] easing
  # @param [Osb::Color, Array<Integer>] start_color
  # @param [Osb::Color,  Array<Integer>] end_color
  # @return [void]
  def color(
    start_time:,
    end_time: start_time,
    easing: Easing::Linear,
    start_color:,
    end_color: start_color
  )
    self.raise_unless_inside_object!
    self.current_object.color(
      start_time: start_time,
      end_time: end_time,
      easing: easing,
      start_color: start_color,
      end_color: end_color
    )
  end

  # Flip the object horizontally or vertically.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @param [Boolean] horizontally
  # @param [Boolean] vertically
  # @return [void]
  def flip(start_time:, end_time:, horizontally: true, vertically: false)
    self.raise_unless_inside_object!
    self.current_object.flip(
      start_time: start_time,
      end_time: end_time,
      horizontally: horizontally,
      vertically: vertically
    )
  end

  # Use additive-color blending instead of alpha-blending.
  # @param [Integer] start_time
  # @param [Integer] end_time
  # @return [void]
  def additive_color_blending(start_time:, end_time:)
    self.raise_unless_inside_object!
    self.current_object.additive_color_blending(
      start_time: start_time,
      end_time: end_time
    )
  end

  # Add a group of commands on a specific condition.
  # `#trigger` can only be called on an empty object declaration (no commands).
  # Pass a block to this method call to specify which commands to run if
  # the condition is met.
  #
  # @example
  #   img.trigger(on: "Passing", start_time: 0, end_time: 1000) do
  #     img.fade(start_time: 0, start_opacity: 0.5)
  #   end
  #
  # In addition to the "implicit" player feedback via the separate
  # Pass/Fail layers, you can use one of several Trigger conditions
  # to cause a series of events to happen whenever that condition is
  # fulfilled within a certain time period.
  # Note that `start_time` and `end_time` of any commands called inside
  # the block become relative to the `start_time` and `end_time` of the
  # `#trigger` command.
  #
  # While osu! supports trigger on hitsounds playing, we decided to not
  # include it in because it is unreliable/unpredictable.
  #
  # @param [String] on indicates the trigger condition. It can be "Failing" or "Passing".
  # @param [Integer] start_time the timestamp at which the trigger becomes valid.
  # @param [Integer] end_time the timestamp at which the trigger stops being valid.
  # @return [void]
  def trigger(on:, start_time:, end_time:, &blk)
    self.raise_unless_inside_object!
    self.current_object.trigger(
      on: on,
      start_time: start_time,
      end_time: end_time,
      &blk
    )
  end
end
