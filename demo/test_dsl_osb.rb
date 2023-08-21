# frozen_string_literal: true

require_relative "../lib/osb"

storyboard do
  out_path File.join(__dir__, "test_dsl.osb")

  sprite file_path: "test.png" do
    fade start_time: 1000, start_opacity: 1
    
    move start_time: 2000, start_position: [320, 640], end_position: [100, 100]

    scale start_time: 100, end_time: 200, start_scale: 1, end_scale: 2

    scale start_time: 100,
          end_time: 200,
          start_scale: [1, 1],
          end_scale: [0.5, 0.2]

    rotate start_time: 1000,
           end_time: 2000,
           start_angle: 0.degrees,
           end_angle: 260.degrees

    color start_time: 0, start_color: [255, 255, 0]

    flip start_time: 0, end_time: 1000, horizontally: true

    additive_color_blending start_time: 0, end_time: 1000
  end

  group name: "Scene 1" do
    sprite file_path: "test1.png" do
      trigger on: "Passing", start_time: 0, end_time: 1000 do
        fade start_time: 1000, start_opacity: 1

        move start_time: 2000,
             start_position: [320, 640],
             end_position: [100, 100]

        scale start_time: 100, end_time: 200, start_scale: 1, end_scale: 2

        scale start_time: 100,
              end_time: 200,
              start_scale: [1, 1],
              end_scale: [0.5, 0.2]

        rotate start_time: 1000,
               end_time: 2000,
               start_angle: 0.degrees,
               end_angle: 260.degrees

        color start_time: 0, start_color: [255, 255, 0]

        flip start_time: 0, end_time: 1000, horizontally: true

        additive_color_blending start_time: 0, end_time: 1000
      end
    end
  end
end
