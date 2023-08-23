# frozen_string_literal: true

module Osb
  # @private
  def raise_unless_inside_storyboard!
    unless @storyboard
      raise RuntimeError,
            "Do not call this method outside of a storyboard context."
    end
  end

  # Set the output directory of this storyboard.
  # @param [String] path path to .osb or .osu file
  def out_path(path)
    self.raise_unless_inside_storyboard!
    @out_path = path
  end

  # Create an osu! storyboard.
  # @return [void]
  def storyboard
    if @storyboard
      raise RuntimeError,
            "Cannot create a new storyboard inside another storyboard."
    end
    @storyboard = Storyboard.new
    yield
    raise RuntimeError, "Output path is not set." unless @out_path
    @storyboard.generate(@out_path)
    @storyboard = nil
  end

  # Create a still image.
  # @param [String] layer the layer the object appears on.
  # @param [String] origin where on the image should osu! consider that image's origin (coordinate) to be.
  # @param [String] file_path filename of the image.
  # @param [Osb::Vector2, nil] initial_position where the object should be by default.
  # @return [void]
  def sprite(
    layer: Layer::Background,
    origin: Origin::Center,
    file_path:,
    initial_position: nil
  )
    self.raise_unless_inside_storyboard!

    if @sprite || @animation
      raise RuntimeError,
            "Cannot create a new sprite inside another sprite/animation."
    end
    @sprite =
      Sprite.new(
        layer: layer,
        origin: origin,
        file_path: file_path,
        initial_position: initial_position
      )
    @storyboard << @sprite
    yield
    @sprite = nil
  end

  # Group multiple objects for clarity.
  # @return [void]
  def group(name: nil)
  end

  # Create a moving image.
  # @param [String] layer the layer the object appears on.
  # @param [String] origin where on the image should osu! consider that image's origin (coordinate) to be.
  # @param [String] file_path filename of the image.
  # @param [Vector2, nil] initial_position where the object should be by default.
  # @param [Integer] frame_count how many frames the animation has.
  # @param [Integer] frame_delay how many milliseconds should be in between each frame.
  # @param [Boolean] repeat if the animation should loop or not.
  # @return [void]
  def animation(
    layer: Osb::Layer::Background,
    origin: Osb::Origin::Center,
    file_path:,
    initial_position: nil,
    frame_count:,
    frame_delay:,
    repeat: false
  )
    self.raise_unless_inside_storyboard!

    if @sprite || @animation
      raise RuntimeError,
            "Cannot create a new animation inside another animation/animation."
    end
    @animation =
      Animation.new(
        layer: layer,
        origin: origin,
        file_path: file_path,
        initial_position: initial_position,
        frame_count: frame_count,
        frame_delay: frame_delay,
        repeat: repeat
      )
    @storyboard << @animation
    yield
    @animation = nil
  end

  # Set the background image for the beatmap.
  # @param [String] file_path location of the background image relative to the beatmap directory.
  # @return [void]
  def background(file_path:)
    self.raise_unless_inside_storyboard!

    @storyboard << Background.new(file_path: file_path)
  end

  # Set the video for the beatmap.
  # @param [String] file_path location of the video file relative to the beatmap directory.
  # @param [Integer] start_time when the video starts.
  # @return [void]
  def video(file_path:, start_time:)
    self.raise_unless_inside_storyboard!

    @storyboard << Video.new(file_path: file_path, start_time: start_time)
  end

  # Add an audio sample to the storyboard.
  # @param [Integer] time the timestamp that the sound should start playing.
  # @param [String] layer the layer you want the sound to be on.
  # @param [String] file_path filename of the audio.
  # @param [Integer] volume indicate the relative loudness of the sound.
  def sample(time:, layer:, file_path:, volume: 100)
    self.raise_unless_inside_storyboard!

    @storyboard << Sample.new(
      time: time,
      layer: layer,
      file_path: file_path,
      volume: volume
    )
  end
end
