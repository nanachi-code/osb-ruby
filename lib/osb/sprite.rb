class Sprite
  attr_reader :commands
  include Commandable
  # @param [String] layer
  # @param [String] origin
  # @param [String] file_path
  # @param [Vector2, nil] initial_position
  def initialize(layer:, origin:, file_path:, initial_position: nil)
    Internal.assert_type!(layer, String, 'layer')
    Internal.assert_value!(layer, Layer::ALL, 'layer')
    Internal.assert_type!(origin, String, 'origin')
    Internal.assert_value!(layer, Origin::ALL, 'type')
    Internal.assert_type!(file_path, String, 'file_path')
    if initial_position 
      Internal.assert_type!(initial_position, Vector2, 'initial_position')
    end
    first_command = "Sprite,#{layer},#{origin},\"#{file_path}\""
    if initial_position
      first_command += ",#{initial_position.x},#{initial_position.y}"
    end
    # @type [Array<String>]
    @commands = [first_command]
  end
end