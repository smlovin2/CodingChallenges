require 'minitest/autorun'

class LLRBTree
  attr_accessor :payload, :left, :right

  def initialize(payload, color = BLACK)
    assign_payload(payload, color)
  end

  def <<(val)
    if @payload.nil?
      assign_payload(val, RED)
    end

    p "Val: #{@payload} Color: #{@color}"

    if @left.is_red? && @right.is_red?
      flip_colors
    end

    if val <= @payload
        @left << val
    else
      @right << val
    end

    if @right.is_red? && !@left.is_red?
      rotate_left
    end
    if @left.is_red? && @left.left.is_red?
      rotate_right
    end

  end

  def to_a

    if @payload.nil?
      return []
    end

    # go down the left side
    array = @left.to_a

    # add the next lowest value to the array
    array << @payload

    # go down the right side
    array << @right.to_a

    array
  end

  def is_red?
    @color
  end

  private

  RED = true
  BLACK = false

  def assign_payload(val, color = BLACK)
    @payload = val
    @color = color
    unless @payload.nil?
      @left = LLRBTree.new(nil)
      @right = LLRBTree.new(nil)
    end
  end

  def rotate_left
    rotating_node = @right
    @right = rotating_node.left
    rotating_node.left = self
    rotating_node.color = @color
    @color = RED
    rotating_node
  end

  def rotate_right
    rotating_node = @left
    @left = rotate_node.right
    rotating_node.right = self
    rotating_node.color = @color
    @color = RED
    rotate_node
  end

  def flip_colors
    @color = !@color
    @left.color = !@left.color
    @right.color = !@right.color
  end

end

def make_llrbtree(data)
  #Empty tree
  trunk = LLRBTree.new(nil)

  # Create the binary tree
  data.each_with_index do |item, index|
    if index == 0
      trunk = LLRBTree.new(item)
    else
      trunk << item
      trunk.color = false
    end
  end

  # Now do depth first search to build the new array
  trunk.to_a
end

class TestFibonacci < MiniTest::Unit::TestCase

  def test_make_llrbtree_1
    assert_equal [1, 4, 6, 7, 9, 10, 14], make_llrbtree([7, 4, 9, 1, 6, 14, 10])
  end

  def test_make_llrbtree_2
    assert_equal [2, 3, 4, 6, 10, 18, 20, 21, 28, 30, 100], make_llrbtree([100, 2, 10, 3, 20, 21, 28, 4, 6, 30, 18])
  end

  def test_btree_negatives
    assert_equal [-100, -14, -1, 0, 1, 2, 4, 5, 21, 30, 90], make_llrbtree([-100, 30, 21, 5, 4, 1, 2, 90, -1, -14, 0])
  end

  def test_btree_only_trunk
    assert_equal [7], make_llrbtree([7])
  end

  def test_btree_empty_array
    assert_equal [], make_llrbtree([])
  end

end

array = [7, 4, 9, 1, 6, 14, 10]
sorted_array = make_llrbtree(array)
puts sorted_array.inspect

array = [100, 2, 10, 3, 20, 21, 28, 4, 6, 30, 18]
sorted_array = make_llrbtree(array)
puts sorted_array.inspect

array = [-100, 30, 21, 5, 4, 1, 2, 90, -1, -14, 0]
sorted_array = make_llrbtree(array)
puts sorted_array.inspect

array = []
sorted_array = make_llrbtree(array)
puts sorted_array.inspect
