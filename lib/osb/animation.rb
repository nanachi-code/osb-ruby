class Animation
  module Loop
    Forever = "Forever"
    Once = "Once"
  end

  attr_reader :commands
  include Commandable

  # @param [String] layer
  # @param [String] origin
  # @param [String] file_path
  # @param [Vector2, nil] initial_position
  # @param [Integer, nil] frame_count
  # @param [Integer, nil] frame_delay
  # @param [String] type
  def initialize(layer:, origin:, file_path:, initial_position: nil, frame_count: nil, frame_delay: nil, type: Animation::Loop::Forever)
    Internal.assert_type!(layer, String, 'layer')
    Internal.assert_value!(layer, Layer::ALL, 'layer')
    Internal.assert_type!(origin, String, 'origin')
    Internal.assert_value!(layer, Origin::ALL, 'type')
    Internal.assert_type!(file_path, String, 'file_path')
    if initial_position 
      Internal.assert_type!(initial_position, Vector2, 'initial_position')
    end
    if frame_count 
      Internal.assert_type!(frame_count, String, 'frame_count')
    end
    if frame_delay 
      Internal.assert_type!(frame_delay, String, 'frame_delay')
    end
    Internal.assert_type!(type, String, 'type')
    Internal.assert_value!(type, ["Forever", "Once"], 'type')

    first_command = "Animation,#{layer},#{origin},\"#{file_path}\""
    if initial_position
      first_command += ",#{initial_position.x},#{initial_position.y}"
    end
    if frame_count
      first_command += ",#{frame_count}"
    end
    if frame_delay
      first_command += ",#{frame_delay}"
    end
    if type
      first_command += ",#{type}"
    end
    # @type [Array<String>]
    @commands = [first_command]
  end
end