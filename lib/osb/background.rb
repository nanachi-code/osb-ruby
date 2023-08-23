# frozen_string_literal: true

module Osb
  # Beatmap's background.
  class Background
    # @private
    attr_reader :command

    # @param [String] file_path location of the background image relative to the beatmap directory.
    def initialize(file_path:)
      Internal.assert_type!(file_path, String, "file_path")
      Internal.assert_file_name_ext!(file_path, %w[png jpg jpeg])
      @command = "0,0,\"#{file_path}\""
    end
  end
end
