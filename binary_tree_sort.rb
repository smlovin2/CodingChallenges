require 'minitest/autorun'

class BinaryTree
  attr_accessor :payload, :left, :right

  def initialize(payload, left, right)
    assign_payload(payload)
  end

  def <<(val)
    if @payload.nil?
      assign_payload(val)
    elsif val <= @payload
        @left << val
    else
      @right << val
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
    array += @right.to_a

    array
  end

  private

  def assign_payload(val)
    @payload = val

    unless @payload.nil?
      @left = BinaryTree.new(nil, nil, nil)
      @right = BinaryTree.new(nil, nil, nil)
    end
  end

end

def btree_sort(data)
  #Empty tree
  trunk = BinaryTree.new(nil, nil, nil)

  # Create the binary tree
  data.each_with_index do |item, index|
    if index == 0
      trunk = BinaryTree.new(item, nil, nil)
    else
      trunk << item
    end
  end

  # Now do depth first search to build the new array
  trunk.to_a
end

class TestFibonacci < MiniTest::Unit::TestCase

  def test_btree_sort_1
    assert_equal [1, 4, 6, 7, 9, 10, 14], btree_sort([7, 4, 9, 1, 6, 14, 10])
  end

  def test_btree_sort_2
    assert_equal [2, 3, 4, 6, 10, 18, 20, 21, 28, 30, 100], btree_sort([100, 2, 10, 3, 20, 21, 28, 4, 6, 30, 18])
  end

  def test_btree_negatives
    assert_equal [-100, -14, -1, 0, 1, 2, 4, 5, 21, 30, 90], btree_sort([-100, 30, 21, 5, 4, 1, 2, 90, -1, -14, 0])
  end

  def test_btree_only_trunk
    assert_equal [7], btree_sort([7])
  end

  def test_btree_empty_array
    assert_equal [], btree_sort([])
  end

end

array = [7, 4, 9, 1, 6, 14, 10]
sorted_array = btree_sort(array)
puts sorted_array.inspect

array = [100, 2, 10, 3, 20, 21, 28, 4, 6, 30, 18]
sorted_array = btree_sort(array)
puts sorted_array.inspect

array = [-100, 30, 21, 5, 4, 1, 2, 90, -1, -14, 0]
sorted_array = btree_sort(array)
puts sorted_array.inspect

array = []
sorted_array = btree_sort(array)
puts sorted_array.inspect
