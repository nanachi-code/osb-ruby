module Osb
  # A video.
  class Video
    # @api private
    attr_reader :commands, :layer

    # @param [String] file_path location of the background image relative to the beatmap directory.
    # @param [Integer] start_time when the video starts.
    def initialize(file_path:, start_time:)
      Internal.assert_type!(file_path, String, "file_path")
      Internal.assert_file_name_ext!(file_path, %w[png jpg jpeg])
      Internal.assert_type!(start_time, Integer, "start_time")

      @command = "1,#{start_time},\"#{file_path}\""
    end
  end
end
