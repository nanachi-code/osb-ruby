require_relative "../lib/osb"

sb = Osb::Storyboard.new

img = Osb::Sprite.new(file_path: "")
sb.add(img)

img.trigger(on: "Passing", start_time: 0.ms, end_time: 1.second) {
  img.fade(start_time: 1.second, start_opacity: 0.5)
}
