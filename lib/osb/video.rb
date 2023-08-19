module Osb
  # A video.
  class Video
    attr_reader :commands, :layer

    # @param [String] file_name location of the background image relative to the beatmap directory.
    # @param [Integer] start_time when the video starts.
    def initialize(file_name:, start_time:)
      Internal.assert_type!(file_name, String, "file_name")
      Internal.assert_file_name_ext!(file_name, %w[png jpg jpeg])
      Internal.assert_type!(start_time, Integer, "start_time")
      
      @command = "1,#{start_time},#{file_name}"
    end
  end
end
