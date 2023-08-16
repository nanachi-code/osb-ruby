module Osb
  # A video.
  class Video
    attr_reader :commands, :layer
    include Internal::Commandable


  end
end
