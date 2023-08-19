# frozen_string_literal: true

module Osb
  module Internal
    # @param [Integer] time
    def self.raise_if_invalid_start_time!(time)
      Internal.assert_type!(time, Integer, "start_time")
    end

    # @param [Integer] time
    def self.raise_if_invalid_end_time!(time)
      Internal.assert_type!(time, Integer, "end_time")
    end

    # @param [Integer] easing
    def self.raise_if_invalid_easing!(easing)
      Internal.assert_type!(easing, Integer, "easing")
      Internal.assert_value!(easing, Easing::ALL, "easing")
    end

    module Commandable
      private def tab_level
        @is_in_trigger ? 2 : 1
      end

      private def raise_if_trigger_called!
        if @trigger_called
          raise RuntimeError, "Do not add commands after #trigger is called."
        end
      end

      # Change the opacity of the object (how transparent it is).
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Numeric] start_opacity
      # @param [Numeric] end_opacity
      def fade(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_opacity:,
        end_opacity: start_opacity
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(start_opacity, Numeric, "start_opacity")
        Internal.assert_type!(end_opacity, Numeric, "end_opacity")
        Internal.assert_value!(start_opacity, 0..1, "start_opacity")
        Internal.assert_value!(end_opacity, 0..1, "end_opacity")

        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command = "#{tabs}F,#{start_time},#{end_time},#{start_opacity}"
        command += ",#{end_opacity}" if end_opacity != start_opacity
        @commands << command
      end

      # Move the object to a new position in the play area.
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Osb::Vector2, Array<Numeric>] start_position
      # @param [Osb::Vector2, Array<Numeric>] end_position
      def move(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_position:,
        end_position: start_position
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(
          start_position,
          [Osb::Vector2, T[Array][Numeric]],
          "start_position"
        )
        Internal.assert_type!(
          end_position,
          [Osb::Vector2, T[Array][Numeric]],
          "end_position"
        )
        if start_position.is_a?(Array)
          start_position = Osb::Vector2.new(start_position)
        end
        if end_position.is_a?(Array)
          end_position = Osb::Vector2.new(end_position)
        end
        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command =
          "#{tabs}M,#{start_time},#{end_time},#{start_position.x},#{start_position.y}"
        command += ",#{end_position.x},#{end_position.y}" if end_position !=
          start_position
        @commands << command
      end

      # Move the object along the x axis.
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Numeric] start_x
      # @param [Numeric] end_x
      def move_x(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_x:,
        end_x: start_x
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(start_x, Numeric, "start_x")
        Internal.assert_type!(end_x, Numeric, "end_x")

        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command = "#{tabs}MX,#{start_time},#{end_time},#{start_x}"
        command += ",#{end_x}" if end_x
        @commands << command
      end

      # Move the object along the y axis.
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Numeric] start_y
      # @param [Numeric] end_y
      def move_y(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_y:,
        end_y: start_y
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time) if end_time
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(start_y, Numeric, "start_y")
        Internal.assert_type!(end_y, Numeric, "end_y")

        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command = "#{tabs}MY,#{start_time},#{end_time},#{start_y}"
        command += ",#{end_y}" if end_y != start_y
        @commands << command
      end

      # Change the size of the object relative to its original size. Will scale
      # seperatedly if given +Vector2+s or +Array<Numeric>+. The scaling is
      # affected by the object's origin
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Numeric, Osb::Vector2, Array<Numeric>] start_scale
      # @param [Numeric, Osb::Vector2, Array<Numeric>] end_scale
      def scale(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_scale:,
        end_scale: start_scale
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time) if end_time
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(
          start_scale,
          [Numeric, T[Array][Numeric], Osb::Vector2],
          "start_scale"
        )
        Internal.assert_type!(
          end_scale,
          [Numeric, T[Array][Numeric], Osb::Vector2],
          "end_scale"
        )

        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level

        if start_scale.is_a?(Numeric)
          unless end_scale.is_a?(Numeric)
            raise InvalidValueError,
                  "start_scale and end_scale must be either both Numeric values or Vector2-like values."
          end
          command = "#{tabs}S,#{start_time},#{end_time},#{start_scale}"
          command += ",#{end_scale}" if end_scale != start_scale
          @commands << command
        else
          if end_scale.is_a?(Numeric)
            raise InvalidValueError,
                  "start_scale and end_scale must be either both Numeric values or Vector2-like values."
          end

          if start_scale.is_a?(Array)
            start_scale = Osb::Vector2.new(start_scale)
          end

          end_scale = Osb::Vector2.new(end_scale) if end_scale.is_a?(Array)

          command =
            "#{tabs}V,#{start_time},#{end_time},#{start_scale.x},#{start_scale.y}"
          command += ",#{end_scale.x},#{end_scale.y}" if end_scale
          @commands << command
        end
      end

      # Rotate the object around its origin.
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Float] start_angle start angle in radians.
      # @param [Float] end_angle end angle in radians.
      def rotate(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_angle:,
        end_angle: start_angle
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(start_angle, Numeric, "start_angle")
        Internal.assert_type!(end_angle, Numeric, "end_angle")

        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command = "#{tabs}R,#{start_time},#{end_time},#{start_angle}"
        command += ",#{end_angle}" if end_angle != start_angle
        @commands << command
      end

      # The virtual light source colour on the object. The colours of the pixels on the object are determined subtractively.
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Integer] easing
      # @param [Osb::Color] start_color
      # @param [Osb::Color] end_color
      def color(
        start_time:,
        end_time: start_time,
        easing: Easing::Linear,
        start_color:,
        end_color: start_color
      )
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.raise_if_invalid_easing!(easing)
        Internal.assert_type!(start_color, Osb::Color, "start_color")
        Internal.assert_type!(end_color, Osb::Color, "end_color")

        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command =
          "#{tabs}C,#{start_time},#{end_time},#{start_color.r},#{start_color.g},#{start_color.b}"
        if end_color != start_color
          command += ",#{end_color.r},#{end_color.g},#{end_color.b}"
        end
        @commands << command
      end

      # Flip the object horizontally or vertically.
      # @param [Integer] start_time
      # @param [Integer] end_time
      # @param [Boolean] horizontally
      # @param [Boolean] vertically
      def flip(start_time:, end_time:, horizontally: true, vertically: false)
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.assert_type!(horizontally, Internal::Boolean, "horizontally")
        Internal.assert_type!(vertically, Internal::Boolean, "vertically")

        if horizontally && vertically
          raise InvalidValueError,
                "Cannot flip an object both horizontally and vertically."
        end
        if !horizontally && !vertically
          raise InvalidValueError, "Specify a direction to flip."
        end

        direction = horizontally ? "H" : "V"
        end_time = "" if start_time == end_time
        tabs = " " * self.tab_level
        command = "#{tabs}P,#{start_time},#{end_time},#{direction}"
        @commands << command
      end

      # Use additive-color blending instead of alpha-blending.
      # @param [Integer] start_time
      # @param [Integer] end_time
      def additive_color_blending(start_time:, end_time:)
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)

        tabs = " " * self.tab_level
        command = "#{tabs}P,#{start_time},#{end_time},A"
        @commands << command
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
      def trigger(on:, start_time:, end_time:)
        self.raise_if_trigger_called!
        Internal.raise_if_invalid_start_time!(start_time)
        Internal.raise_if_invalid_end_time!(end_time)
        Internal.assert_type!(on, String, "on")
        Internal.assert_value!(on, %w[Passing Failing], "on")

        unless block_given?
          raise InvalidValueError, "Do not use an empty trigger."
        end

        if @commands.size > 1
          raise RuntimeError, "Do not call #trigger after any other commands."
        end

        if @is_in_trigger
          raise RuntimeError,
                "Do not call #trigger inside another #trigger block."
        end

        command = " T,#{on},#{start_time},#{end_time}"
        @commands << command

        @is_in_trigger = true
        yield self
        unless @commands.size > 1
          raise InvalidValueError, "Do not use an empty trigger."
        end
        @is_in_trigger = false
        @trigger_called = true
      end
    end
  end
end
