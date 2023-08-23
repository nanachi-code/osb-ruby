# frozen_string_literal: true

module Osb
  # Storyboard object origin enums.
  module Origin
    TopLeft = "TopLeft"
    TopCentre = "TopCentre"
    TopCenter = "TopCentre"
    TopRight = "TopRight"
    CentreLeft = "CentreLeft"
    CenterLeft = "CentreLeft"
    Centre = "Centre"
    Center = "Centre"
    CentreRight = "CentreRight"
    CenterRight = "CentreRight"
    BottomLeft = "BottomLeft"
    BottomCentre = "BottomCentre"
    BottomCenter = "BottomCentre"
    BottomRight = "BottomRight"
    # @private
    ALL = %w[
      TopLeft
      TopCentre
      TopRight
      CentreLeft
      Centre
      CentreRight
      BottomLeft
      BottomCentre
      BottomRight
    ]
  end
end
