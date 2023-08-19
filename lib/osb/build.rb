module Osb
  # @param [String] out_path
  # @param [Storyboard] storyboard
  def self.build(storyboard, out_path)
    Internal.assert_file_name_ext!(out_path, %w[osb osu])

    case File.extname(out_path)
    when ".osu"
      unless File.exist?(out_path)
        raise InvalidValueError, "Cannot find osu file."
      end

      out_osu_file = []
      File
        .readlines(out_path)
        .each do |line|
          if line.match(/[Events]/)
            out_osu_file << storyboard.to_s
          else
            out_osu_file << line
          end
        end

      File.write(out_osu_file.join("\r\n"), out_path)
    when ".osb"
      File.write(storyboard.to_s, out_path)
    else
      raise InvalidValueError, "Not osu or osb file." # should not be here
    end
  end
end
