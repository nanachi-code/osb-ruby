# frozen_string_literal: true

require_relative "osb/integer"
require_relative "osb/assert"
require_relative "osb/math"
require_relative "osb/vector2"
require_relative "osb/color"
require_relative "osb/enums/layer"
require_relative "osb/enums/easing"
require_relative "osb/enums/origin"
require_relative "osb/commandable"
require_relative "osb/animation"
require_relative "osb/sprite"
require_relative "osb/sample"
require_relative "osb/video"
require_relative "osb/background"
require_relative "osb/storyboard"

module Osb
  # @param [String] out_path
  # @param [Storyboard] storyboard
  def self.build(storyboard, out_path)
    File.write(storyboard.commands, out_path)
  end
end
