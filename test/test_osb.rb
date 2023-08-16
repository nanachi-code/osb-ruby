require_relative "lib/osb"

class TestOsb < Minitest::Test
  def it_generates_all_commands_normally
    sb = Storyboard.new

    img = Sprite.new(file_path: "")
    sb.add(img)

    img.fade(start_time: 0, start_opacity: 1)
  end
end
