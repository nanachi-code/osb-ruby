# frozen_string_literal: true

module Osb
  # Storyboard layer enums.
  module Layer
    Background = "Background"
    Fail = "Fail"
    Pass = "Pass"
    Foreground = "Foreground"
    Overlay = "Overlay"
    # @private
    ALL = %w[Background Fail Pass Foreground Overlay]
  end
end
