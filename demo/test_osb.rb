# frozen_string_literal: true

require_relative "../lib/osb"
include Osb

sb = Storyboard.new

bg = Background.new(file_path: "test.png")

sp = Sprite.new(file_path: "test.png")
sp.fade(start_time: 1000, start_opacity: 1)
sp.move(start_time: 2000, start_position: [320, 640], end_position: [100, 100])
sp.scale(start_time: 100, end_time: 200, start_scale: 1, end_scale: 2)
sp.scale(
  start_time: 100,
  end_time: 200,
  start_scale: [1, 1],
  end_scale: [0.5, 0.2]
)
sp.rotate(
  start_time: 1000,
  end_time: 2000,
  start_angle: 0.degrees,
  end_angle: 260.degrees
)
sp.color(start_time: 0, start_color: [255, 255, 0])
sp.flip(start_time: 0, end_time: 1000, horizontally: true)
sp.additive_color_blending(start_time: 0, end_time: 1000)

sb << bg << sp

scene1 = Group.new
sp1 = Sprite.new(file_path: "test1.png")
sp1.trigger(on: "Passing", start_time: 0, end_time: 1000) do |it|
  it.fade(start_time: 1000, start_opacity: 1)
  it.move(
    start_time: 2000,
    start_position: [320, 640],
    end_position: [100, 100]
  )
  it.scale(start_time: 100, end_time: 200, start_scale: 1, end_scale: 2)
  it.scale(
    start_time: 100,
    end_time: 200,
    start_scale: [1, 1],
    end_scale: [0.5, 0.2]
  )
  it.rotate(
    start_time: 1000,
    end_time: 2000,
    start_angle: 0.degrees,
    end_angle: 260.degrees
  )
  it.color(start_time: 0, start_color: Color.new(255, 255, 0))
  it.flip(start_time: 0, end_time: 1000, horizontally: true)
  it.additive_color_blending(start_time: 0, end_time: 1000)
end
scene1 << sp1

sb << scene1

sb.generate(File.join(__dir__, "test.osb"))
