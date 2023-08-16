require_relative "../lib/osb"

begin
  sb = Osb::Storyboard.new

  img = Osb::Sprite.new(file_path: "x. jpg")
  sb.add(img)

  img.trigger(on: "Passing1", start_time: 0, end_time: 1.second) do
    img.fade(start_time: 1.second, start_opacity: 0.5)
  end
rescue StandardError => e
  message =
    "\e[1m\e[31m#{e.class.name}\e[0m\e[1m " + e.message + "\e[0m\r\n\tat " +
      Kernel.caller_locations.first.to_s

  puts message
end
