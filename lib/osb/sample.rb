module Osb
  class Sample
    attr_reader :layer

    # @param [Integer] time the timestamp that the sound should start playing.
    # @param [String] layer the layer you want the sound to be on.
    # @param [String] file_path filename of the audio.
    # @param [Integer] volume indicate the relative loudness of the sound.
    def initialize(time:, layer:, file_path:, volume: 100)
      Internal.assert_type!(layer, String, "layer")
      Internal.assert_value!(layer, Layer::ALL, "layer")
      Internal.assert_type!(file_path, String, "file_path")

      @layer = layer
      layer_ =
        case layer
        when Osb::Layer::Background
          0
        when Osb::Layer::Foreground
          1
        when Osb::Layer::Fail
          2
        when Osb::Layer::Pass
          3
        else
          raise ArgumentError,
                "An audio sample can only exists in one of these layers: " +
                  "Background, Foreground, Fail or Pass."
        end

      @commands = ["Sample,#{time},#{layer_},\"#{file_path}}\",#{volume}"]
    end
  end
end
