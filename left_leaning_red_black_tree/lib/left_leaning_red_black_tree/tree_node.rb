require './lib/left_leaning_red_black_tree/printable'
module LeftLeaningRedBlackTree
  class TreeNode
    include Printable
    attr_accessor :val, :color, :left, :right

    def initialize(val)
      @val = val
      @color = RED
      unless val.nil?
        @left = NullNode.new
        @right = NullNode.new
      end
      self
    end

    def insert(val)
      if @left.red? && @right.red?
        flip_colors
      end

      if val <= @val
        @left = @left.insert(val)
      else
        @right = @right.insert(val)
      end

      fix_up
    end

    def delete(val)
      parent = self
      if val < @val
        if !@left.red? && !@left.left.red?
          parent = move_red_left
        end
        parent.left = parent.left.delete(val)
      else
        if @left.red?
          parent = rotate_right
        end
        if val == parent.val && parent.right.val.nil?
          return NullNode.new
        end
        if !parent.right.red? && !parent.right.left.red?
          parent = move_red_right
        end
        if val == parent.val
          parent.val = parent.right.min_node.val
          parent.right = parent.right.delete_min
        else
          parent.right = parent.right.delete(val)
        end
      end
      parent.fix_up
    end

    def to_a

      if @val.nil?
        return []
      end

      # go down the left side
      array = @left.to_a

      # add the next lowest value to the array
      array << @val

      # go down the right side
      array << @right.to_a

      array.flatten
    end

    def red?
      @color
    end

    def black?
      !red?
    end

    def flip_colors
      @color = !@color
      @left.color = !@left.color
      @right.color = !@right.color
    end

    def rotate_left
      new_parent = @right
      @right = new_parent.left
      new_parent.left = self
      new_parent.color = @color
      @color = RED
      new_parent
    end

    def rotate_right
      new_parent = @left
      @left = new_parent.right
      new_parent.right = self
      new_parent.color = @color
      @color = RED
      new_parent
    end

    def delete_min
      parent = self

      if @left.val.nil?
        return NullNode.new
      end

      if !@left.red? && !@left.left.red?
        parent = move_red_left
      end

      parent.left = parent.left.delete_min

      fix_up
    end

    def min_node
      cur_node = self
      while !cur_node.left.val.nil? do
        cur_node = cur_node.left
      end

      cur_node
    end

    def move_red_left
      parent = self
      flip_colors
      if @right.left.red?
        @right = @right.rotate_right
        parent = rotate_left
        flip_colors
      end
      parent
    end

    def move_red_right
      parent = self
      flip_colors
      if @left.left.red?
        parent = rotate_right
        flip_colors
      end
      parent
    end

    def fix_up
      parent = self

      if left_rotation_required?
        parent = rotate_left
      elsif right_rotation_required?
        parent = rotate_right
      end

      parent
    end

    def null?
      false
    end

    private

    def left_rotation_required?
      @right.red? && @left.black?
    end

    def right_rotation_required?
      @left.red? && @left.left.red?
    end
  end
end
