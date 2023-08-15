# Represent a osu! storyboard. Each sprite or animation can be added directly 
# to the storyboard instance, or through an intermediate "scene", which can be added later.
class Storyboard
  def initialize
    @nodes = []
  end

  # @param [Scene, Sprite, Animation] obj
  def <<(obj)
    @nodes << obj
  end 

  # @return [String]
  def commands
    @node.map(&:commands)
  end
end