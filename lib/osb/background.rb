module Osb
  # Beatmap's background.
  class Background
    attr_reader :command

    # @param [String] file_name location of the background image relative to the beatmap directory.
    def initialize(file_name:)
      Internal.assert_type!(file_name, String, "file_name")
      Internal.assert_file_name_ext!(file_name, %w[png jpg jpeg])
      @command = "0,0,#{file_name}"
    end
  end
end
