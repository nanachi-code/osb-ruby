# frozen_string_literal: true

module Osb
  # A still image.
  class Sprite
    # @private
    attr_reader :commands, :layer
    include Commandable

    # @param [String] layer the layer the object appears on.
    # @param [String] origin where on the image should osu! consider that image's origin (coordinate) to be.
    # @param [String] file_path filename of the image.
    # @param [Osb::Vector2, nil] initial_position where the object should be by default.
    def initialize(
      layer: Layer::Background,
      origin: Origin::Center,
      file_path:,
      initial_position: nil
    )
      Internal.assert_type!(layer, String, "layer")
      Internal.assert_value!(layer, Layer::ALL, "layer")
      Internal.assert_type!(origin, String, "origin")
      Internal.assert_value!(origin, Origin::ALL, "origin")
      Internal.assert_type!(file_path, String, "file_path")
      Internal.assert_file_name_ext!(file_path, %w[png jpg jpeg])
      if initial_position
        Internal.assert_type!(
          initial_position,
          Osb::Vector2,
          "initial_position"
        )
      end

      @layer = layer

      first_command = "Sprite,#{layer},#{origin},\"#{file_path}\""
      if initial_position
        first_command += ",#{initial_position.x},#{initial_position.y}"
      end
      # @type [Array<String>]
      @commands = [first_command]
    end
  end
end
