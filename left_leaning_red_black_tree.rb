require 'minitest/autorun'

class LLRBTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(val)
    @root = insert_val(root, val)
    @root.color = BLACK
  end

  def delete(val)
    @root = delete_val(@root, val)
    @root.color = BLACK
  end

  def to_a(node)

    if node == nil
      return []
    end

    # go down the left side
    array = to_a(node.left)

    # add the next lowest value to the array
    array << node.val

    # go down the right side
    array << to_a(node.right)

    array
  end

  def print_tree(node)
    if node == nil
      return
    end
    queue = []
    nodesInCurrentLevel = 1
    nodesInNextLevel = 0
    queue.push(node)

    while !queue.empty? do
      cur_node = queue.shift
      nodesInCurrentLevel = nodesInCurrentLevel - 1
      if cur_node != nil
        print "#{cur_node.val} "
        queue.push(cur_node.left)
        queue.push(cur_node.right)
        nodesInNextLevel = nodesInNextLevel + 2
      end
      if nodesInCurrentLevel == 0
        puts
        nodesInCurrentLevel = nodesInNextLevel
        nodesInNextLevel = 0
      end
    end
  end

  private

  class TreeNode
    attr_accessor :val, :color, :left, :right
    def initialize(val)
      @val = val
      @color = RED
      @left = nil
      @right = nil
    end
  end

  RED = true
  BLACK = false

  def insert_val(node, val)
    if node == nil
      return TreeNode.new(val)
    end

    if is_red(node.left) && is_red(node.right)
      flip_colors(node)
    end

    if val <= node.val
      node.left = insert_val(node.left, val)
    else
      node.right = insert_val(node.right, val)
    end

    fix_up(node)
  end

  def delete_val(node, val)
    if val < node.val
      if !is_red(node.left) && !is_red(node.left.left)
        node = move_red_left(node)
      end
      node.left = delete_val(node.left, val)
    else
      if is_red(node.left)
        node = rotate_right(node)
      end
      if val == node.val && node.right == nil
        return nil
      end
      if !is_red(node.right) && !is_red(node.right.left)
        node = move_red_right(node)
      end
      if val == node.val
        node.val = min_node(node.right).val
        node.right = delete_min(node.right)
      else
        node.right = delete_val(node.right, val)
      end
    end
    fix_up(node)
  end

  def delete_min(node)
    if node.left == nil
      return
    end

    if !is_red(node.left) && !is_red(node.left.left)
      node. move_red_left(node)
    end

    node.left = delete_min(node.left)

    fix_up(node)
  end

  def min_node(node)
    cur_node = node
    while cur_node.left != nil do
      cur_node = cur_node.left
    end

    cur_node
  end

  def is_red(node)
    if node == nil
      return false
    end

    node.color
  end

  def fix_up(node)
    if is_red(node.right) && !is_red(node.left)
      node = rotate_left(node)
    end
    if is_red(node.left) && is_red(node.left.left)
      node = rotate_right(node)
    end

    node
  end

  def rotate_left(node)
    new_parent_node = node.right
    node.right = new_parent_node.left
    new_parent_node.left = node
    new_parent_node.color = node.color
    node.color = RED
    new_parent_node
  end

  def rotate_right(node)
    new_parent_node = node.left
    node.left = new_parent_node.right
    new_parent_node.right = node
    new_parent_node.color = node.color
    node.color = RED
    new_parent_node
  end

  def flip_colors(node)
    node.color = !node.color
    node.left.color = !node.left.color
    node.right.color = !node.right.color
  end

  def move_red_left(node)
    flip_colors(node)
    if is_red(node.right.left)
      node.right = rotate_right(node.right)
      node = rotate_left(node)
      flip_colors(node)
    end
    node
  end

  def move_red_right(node)
    flip_colors(node)
    if is_red(node.left.left)
      node = rotate_right(node)
      flip_colors(node)
    end
    node
  end

end

def make_llrbtree(data)
  #Empty tree
  tree = LLRBTree.new

  # Create the binary tree
  data.each_with_index do |item, index|
    tree.insert(item)
  end

  # Now do depth first search to build the new array
  tree.to_a(tree.root).flatten
end

def llrb_deleting(data, val_to_delete)
  tree = LLRBTree.new

  data.each_with_index do |item, index|
    tree.insert(item)
  end

  tree.delete(val_to_delete)

  tree.to_a(tree.root).flatten
end

class TestLLRB < MiniTest::Unit::TestCase

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

  def test_delete_leaf
    assert_equal [4, 6, 7, 9, 10, 14], llrb_deleting([7, 4, 9, 1, 6, 14, 10], 1)
  end

  def test_delete_middle_node
    assert_equal [1, 6, 7, 9, 10, 14], llrb_deleting([7, 4, 9, 1, 6, 14, 10], 4)
  end

  def test_delete_root
    assert_equal [1, 4, 6, 9, 10, 14], llrb_deleting([7, 4, 9, 1, 6, 14, 10], 7)
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
