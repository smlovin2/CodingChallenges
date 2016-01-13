require './tree_node'
module LLRB
  class NullNode < TreeNode
    def initialize
      super(nil)
      @color = BLACK
    end

    def null?
      true
    end

    def max_level
      0
    end

    def insert(val)
      TreeNode.new(val)
    end
  end
end
