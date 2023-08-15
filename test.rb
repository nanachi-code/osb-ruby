require_relative "lib/osb"

sb = Storyboard.new

img = Sprite.new(file_path: "")
sb.add(img)

img.fade(start_time: 0, start_opacity: 1)

puts sb.commands
