require './constants'
require './null_node'
module LLRB
  class Tree
    attr_accessor :root

    def initialize
      @root = NullNode.new
    end

    def insert(val)
      @root = @root.insert(val)
      @root.color = BLACK
    end

    def delete(val)
      @root = @root.delete(val)
      @root.color = BLACK
    end

    def print_tree
      root.print_node([@root], 1, @root.max_level)
    end
  end
end
