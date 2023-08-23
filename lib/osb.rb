# frozen_string_literal: true

require_relative "osb/integer"
require_relative "osb/numeric"
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
require_relative "osb/dsl/object"
require_relative "osb/dsl/commands"

module Osb
  VERSION = "1.1.2"
end

# Extend the main object with the DSL commands.
extend Osb
