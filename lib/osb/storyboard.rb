# When designing storyboard, we often want to group storyboard elements
# that are used in a similar context (eg. a scene), so this class' purpose
# is only to act as a container. You can add the elements directly to the
# +Storyboard+ object, but we recommend you to split the project into multiple
# +Group+ so it will be easier to manage. A group can have multiple nested
# groups in itself.
class Group
end

# Represent a osu! storyboard. Each sprite or animation can be added directly
# to the storyboard instance, or through an intermediate group.
class Storyboard < Group
  attr_reader :nodes
  # @attribute [r] nodes
  #   @return The underlying tree used to generate the storyboard.

  def initialize
    # @type [Array<Group, Sprite, Animation>]
    @nodes = []
  end

  # Add a +Sprite+, +Animation+ or +Group+ to this storyboard.
  # @param [Group, Sprite, Animation] object
  # @return [self]
  def add(object)
    Internal.assert_type!(object, [Group, Sprite, Animation], "object")

    @nodes << object

    return self
  end

  # Add a +Sprite+, +Animation+ or +Group+ to this storyboard.
  # Alias for +#add+.
  # @param [Group, Sprite, Animation] object
  # @return [self]
  def <<(object)
    self.add(object)
  end

  # @return [String]
  def commands
    @nodes.map(&:commands)
  end
end
