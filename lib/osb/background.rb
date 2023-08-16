module Osb
  # Beatmap's background.
  class Background
    attr_reader :commands, :layer
    include Internal::Commandable
  end
end
