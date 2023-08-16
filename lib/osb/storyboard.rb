# frozen_string_literal: true

module Osb
  module Internal
    class LayerManager
      attr_accessor :background, :foreground, :fail, :pass, :overlay

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
      end

      # @param [Osb::Sprite, Osb::Animation] object
      def add(object)
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
      end

      # @param [Osb::Group] group
      def concat(group)
        self.background.concat(group.layers.background)
        self.foreground.concat(group.layers.foreground)
        self.fail.concat(group.layers.fail)
        self.pass.concat(group.layers.pass)
        self.overlay.concat(group.layers.overlay)
      end
    end
  end

  # When designing storyboard, we often want to group storyboard elements
  # that are used in a similar context (eg. a scene), so this class' purpose
  # is only to act as a container. You can add the elements directly to the
  # +Osb::Storyboard+ object, but we recommend you to split the project into multiple
  # +Osb::Group+ so it will be easier to manage.
  class Group
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
        [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample],
        "object"
      )

      case object
      when Osb::Sprite, Osb::Animation
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
    attr_reader :layers

    def initialize
      @layers = Internal::LayerManager.new
    end

    # Add an +Osb::Sprite+, +Osb::Animation+, +Osb::Sample+, +Osb::Video+, 
    # +Osb::Background+ or +Osb::Group+ to this storyboard.
    # @param [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample, Osb::Video, Osb::Background] object
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
      when Osb::Sprite, Osb::Animation
        @layers.add(object)
      when Osb::Group
        @layers.concat(object)
      end

      return self
    end

    # Add an +Osb::Sprite+, +Osb::Animation+, +Osb::Sample+, +Osb::Video+, 
    # +Osb::Background+ or +Osb::Group+ to this storyboard. Alias for +#add+.
    # @param [Osb::Group, Osb::Sprite, Osb::Animation, Osb::Sample, Osb::Video, Osb::Background] object
    # @return [self]
    def <<(object)
      self.add(object)
    end
  end
end
