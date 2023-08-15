require_relative 'osb/assert_type'
require_relative 'osb/commandable'
require_relative 'osb/animation'
require_relative 'osb/vector2'
require_relative 'osb/color'
require_relative 'osb/sprite'
require_relative 'osb/storyboard'
require_relative 'osb/helpers/layer'
require_relative 'osb/helpers/easing'
require_relative 'osb/helpers/origin'

module Osb
  # @param [String] out_path
  # @param [Storyboard] storyboard
  def self.build(storyboard, out_path)
    File.write(storyboard.commands, out_path)
  end
end