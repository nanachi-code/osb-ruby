# frozen_string_literal: true

module Osb
  # A moving image.
  class Animation
    attr_reader :commands, :layer
    include Internal::Commandable

    # @param [String] layer the layer the object appears on.
    # @param [String] origin where on the image should osu! consider that image's origin (coordinate) to be.
    # @param [String] file_path filename of the image.
    # @param [Vector2, nil] initial_position where the object should be by default.
    # @param [Integer] frame_count how many frames the animation has.
    # @param [Integer] frame_delay how many milliseconds should be in between each frame.
    # @param [Boolean] repeat if the animation should loop or not.
    def initialize(
      layer: Osb::Layer::Background,
      origin: Osb::Origin::Center,
      file_path:,
      initial_position: nil,
      frame_count:,
      frame_delay:,
      repeat: false
    )
      Internal.assert_type!(layer, String, "layer")
      Internal.assert_value!(layer, Osb::Layer::ALL, "layer")

      Internal.assert_type!(origin, String, "origin")
      Internal.assert_value!(origin, Osb::Origin::ALL, "origin")

      Internal.assert_type!(file_path, String, "file_path")
      Internal.assert_file_name_ext!(file_path, %w[png jpg jpeg])
      if initial_position
        Internal.assert_type!(initial_position, Vector2, "initial_position")
      end

      Internal.assert_type!(frame_count, Integer, "frame_count") if frame_count

      Internal.assert_type!(frame_delay, Integer, "frame_delay") if frame_delay

      Internal.assert_type!(repeat, Internal::Boolean, "repeat")

      @layer = layer

      first_command = "Animation,#{layer},#{origin},\"#{file_path}\""
      first_command +=
        ",#{initial_position.x},#{initial_position.y}" if initial_position
      first_command += ",#{frame_count}" if frame_count
      first_command += ",#{frame_delay}" if frame_delay
      looptype = repeat ? "LoopForever" : "LoopOnce"
      first_command += ",#{type}" if repeat
      # @type [Array<String>]
      @commands = [first_command]
    end

    def to_s
      @commands.to_s
    end
  end
end
