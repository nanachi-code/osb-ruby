# frozen_string_literal: true

module Osb
  # @api private
  module Internal
    # @api private
    class LayerManager
      attr_reader :background,
                  :foreground,
                  :fail,
                  :pass,
                  :overlay,
                  :samples,
                  :bg_and_video

      def initialize
        # @type [Array<Osb::Sprite, Osb::Animation>]
        @background = []
        # @type [Array<Osb::Sprite, Osb::Animation>]
        @foreground = []
        # @type [Array<Osb::Sprite, Osb::Animation>]
        @fail = []
        # @type [Array<Osb::Sprite, Osb::Animation>]
        @pass = []
        # @type [Array<Osb::Sprite, Osb::Animation>]
        @overlay = []
        # @type [Array<Osb::Background, Osb::Video>]
        @bg_and_video = []
        # @type [Array<Osb::Sample>]
        @samples = []
      end

      # @param [Osb::Sprite, Osb::Animation, Osb::Sample, Osb::Background, Osb::Video] object
      def add(object)
        case object
        when Osb::Sprite, Osb::Animation
          case object.layer
          when Layer::Background
            @background << object
          when Layer::Foreground
            @foreground << object
          when Layer::Fail
            @fail << object
          when Layer::Pass
            @pass << object
          when Layer::Overlay
            @overlay << object
          end
        when Osb::Sample
          @samples << object
        when Osb::Background, Osb::Video
          @bg_and_video << object
        end
      end

      # @param [Osb::Group] group
      def concat(group)
        @background.concat(group.layers.background)
        @foreground.concat(group.layers.foreground)
        @fail.concat(group.layers.fail)
        @pass.concat(group.layers.pass)
        @overlay.concat(group.layers.overlay)
        @samples.concat(group.layers.samples)
      end
    end
  end

  # When designing storyboard, we often want to group storyboard elements
  # that are used in a similar context (eg. a scene), so this class' purpose
  # is only to act as a container. You can add the elements directly to the
  # +Osb::Storyboard+ object, but we recommend you to split the project into multiple
  # +Osb::Group+ so it will be easier to manage.
  class Group
    # @api private
    attr_reader :layers

    def initialize
      @layers = Internal::LayerManager.new
    end

    # Add an +Osb::Sprite+, +Osb::Animation+, +Osb::Sample+ or +Osb::Group+ to
    # this group.
    # @param [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample] object
    # @return [self]
    def add(object)
      Internal.assert_type!(
        object,
        [
          Osb::Group,
          Osb::Sprite,
          Osb::Animation,
          Osb::Sample,
          Osb::Video,
          Osb::Background
        ],
        "object"
      )

      case object
      when Osb::Sprite, Osb::Animation, Osb::Sample
        @layers.add(object)
      when Osb::Group
        @layers.concat(object)
      end

      return self
    end

    # Add an +Osb::Sprite+, +Osb::Animation+, +Osb::Sample+ or +Osb::Group+ to
    # this group. Alias for +#add+.
    # @param [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample] object
    # @return [self]
    def <<(object)
      self.add(object)
    end
  end

  # Represent a osu! storyboard. Each sprite or animation can be added directly
  # to the storyboard instance, or through an intermediate group. A group can
  # have multiple nested groups in itself.
  class Storyboard
    # @api private
    attr_reader :layers

    def initialize
      @layers = Internal::LayerManager.new
    end

    # Add an +Osb::Sprite+, +Osb::Animation+, +Osb::Sample+, +Osb::Video+,
    # +Osb::Background+ or +Osb::Group+ to this storyboard.
    # @param [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample, Osb::Video,
    #         Osb::Background] object
    # @return [self]
    def add(object)
      Internal.assert_type!(
        object,
        [
          Osb::Group,
          Osb::Sprite,
          Osb::Animation,
          Osb::Video,
          Osb::Background,
          Osb::Sample
        ],
        "object"
      )

      case object
      when Osb::Sprite, Osb::Animation, Osb::Sample, Osb::Video, Osb::Background
        @layers.add(object)
      when Osb::Group
        @layers.concat(object)
      end

      return self
    end

    # Add an +Osb::Sprite+, +Osb::Animation+, +Osb::Sample+, +Osb::Video+,
    # +Osb::Background+ or +Osb::Group+ to this storyboard. Alias for +#add+.
    # @param [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample, Osb::Video,
    #         Osb::Background] object
    # @return [self]
    def <<(object)
      self.add(object)
    end

    # Returns the storyboard string.
    # @return [String]
    def to_s
      bg_and_video_layer =
        @layers.bg_and_video.map { |object| object.command }.join("\n")
      background_layer =
        @layers
          .background
          .map { |object| object.commands.join("\n") }
          .join("\n")
      fail_layer =
        @layers.fail.map { |object| object.commands.join("\n") }.join("\n")
      pass_layer =
        @layers.pass.map { |object| object.commands.join("\n") }.join("\n")
      foreground_layer =
        @layers
          .foreground
          .map { |object| object.commands.join("\n") }
          .join("\n")
      overlay_layer =
        @layers.overlay.map { |object| object.commands.join("\n") }.join("\n")
      samples_layer = @layers.samples.map { |object| object.command }.join("\n")

      osb_string = "[Events]\n"
      osb_string +=
        "//Background and Video events\n" + bg_and_video_layer + "\n" +
          "//Storyboard Layer 0 (Background)\n" + background_layer + "\n" +
          "//Storyboard Layer 1 (Fail)\n" + fail_layer + "\n" +
          "//Storyboard Layer 2 (Pass)\n" + pass_layer + "\n" +
          "//Storyboard Layer 3 (Foreground)\n" + foreground_layer + "\n" +
          "//Storyboard Layer 4 (Overlay)\n" + overlay_layer + "\n" +
          "//Storyboard Sound Samples\n" + samples_layer + "\n"
    end

    # Generate an osb or osu file for this storyboard.
    # @param [String] out_path path to .osb or .osu file
    # @return [void]
    def generate(out_path)
      Internal.assert_file_name_ext!(out_path, %w[osb osu])

      case File.extname(out_path)
      when ".osu"
        unless File.exist?(out_path)
          raise InvalidValueError, "Cannot find osu file."
        end

        out_osu_file = ""
        File
          .readlines(out_path)
          .each do |line|
            if line.match(/[Events]/)
              out_osu_file += self.to_s
            else
              out_osu_file += line
            end
          end

        File.new(out_path, "w").write(out_osu_file)
      when ".osb"
        File.new(out_path, "w").write(self.to_s)
      else
        raise InvalidValueError, "Not osu or osb file." # should not be here
      end
    end
  end
end
