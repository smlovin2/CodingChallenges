require 'minitest/autorun'

RED = true
BLACK = false

class LLRBTree
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

class TreeNode
  attr_accessor :val, :color, :left, :right

  def initialize(val)
    @val = val
    @color = RED
    if !val.nil?
      @left = NullNode.new
      @right = NullNode.new
    end
  end

  def insert(val)
    if @val.nil?
      return assign_val(val)
    end

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

    if @right.red? && !@left.red?
      parent = rotate_left
    end
    if @left.red? && @left.left.red?
      parent = rotate_right
    end

    parent
  end

  def assign_val(val)
    @val = val
    @color = RED
    unless val.nil?
      @left = NullNode.new
      @right = NullNode.new
    end
    self
  end

  def print_node(nodes, level, max_level)
    if nodes.empty? || all_elements_nil(nodes)
      return
    end

    floor = max_level - level;
    endge_lines = 2 ** ([floor - 1, 0].max)
    first_spaces = (2 ** floor) - 1
    between_spaces = (2 ** (floor + 1)) - 1;

    print_white_spaces(first_spaces);

    new_nodes = []
    nodes.each do |node|
        if node.val.nil?
          new_nodes << NullNode
          new_nodes << NullNode
          print " "
        else
          print(node.val);
          new_nodes << node.left
          new_nodes << node.right
        end

        print_white_spaces(between_spaces);
    end
    puts

    1.upto(endge_lines) do |i|
        nodes.each do |node|
            print_white_spaces(first_spaces - i);
            if node.val.nil?
                print_white_spaces(endge_lines + endge_lines + i + 1);
                next
            end

            if node.left.val.nil?
              print_white_spaces(1);
            else
              print "/"
            end

            print_white_spaces(i + i - 1);

            if node.right.val.nil?
              print_white_spaces(1);
            else
              print "\\"
            end

            print_white_spaces(endge_lines + endge_lines - i);
        end

        puts
    end

    print_node(new_nodes, level + 1, max_level);
  end

  def print_white_spaces(count)
    count.times do
      print " "
    end
  end

  def max_level
    if @val.nil?
      return 0
    end

    [@left.max_level, @right.max_level].max + 1
  end

  def all_elements_nil(nodes)
    nodes.each do |node|
      if !node.val.nil?
        return false
      end
    end

    true
  end
end

class NullNode < TreeNode
  def initialize
    super(nil)
    @color = BLACK
  end

  def self.val
    @val
  end
end

class TestLLRB < MiniTest::Unit::TestCase

  def test_empty_tree
    tree = LLRBTree.new
    assert(tree.root)
  end

  def test_flip_colors
    root = TreeNode.new(1)
    root.color = BLACK
    root.left = TreeNode.new(2)
    root.right = TreeNode.new(3)
    root.flip_colors
    assert_equal(RED, root.color)
    assert_equal(BLACK, root.right.color)
    assert_equal(BLACK, root.right.right.color)
  end

  def test_rotate_right
    root = TreeNode.new(1)
    root.color = BLACK
    root.left = TreeNode.new(2)
    root.right = TreeNode.new(3)
    root = root.rotate_right
    assert_equal(2, root.val)
    assert_equal(BLACK, root.color)
    assert_equal(1, root.right.val)
    assert_equal(RED, root.right.color)
    assert_equal(3, root.right.right.val)
    assert_equal(RED, root.right.right.color)
  end

  def test_rotate_left
    root = TreeNode.new(1)
    root.color = BLACK
    root.left = TreeNode.new(2)
    root.right = TreeNode.new(3)
    root = root.rotate_left
    assert_equal(3, root.val)
    assert_equal(BLACK, root.color)
    assert_equal(1, root.left.val)
    assert_equal(RED, root.left.color)
    assert_equal(2, root.left.left.val)
    assert_equal(RED, root.left.left.color)
  end

  def test_add_root
    tree = LLRBTree.new
    tree.insert(7)
    assert_equal(7, tree.root.val)
    assert_equal(BLACK, tree.root.color)
  end

  def test_insert_lesser_node
    tree = LLRBTree.new
    tree.insert(7)
    tree.insert(5)
    assert_equal(5, tree.root.left.val)
    assert_equal(RED, tree.root.left.color)
  end

  def test_insert_greater_node_without_rotation
    tree = LLRBTree.new
    tree.insert(7)
    tree.insert(5)
    tree.insert(10)
    print "\n\n"
    tree.print_tree
    assert_equal(10, tree.root.right.val)
    assert_equal(RED, tree.root.right.color)
  end

  def test_insert_greater_node_with_rotation
    tree = LLRBTree.new
    tree.insert(7)
    tree.insert(10)
    assert_equal(10, tree.root.val)
    assert_equal(BLACK, tree.root.color)
  end

  def test_to_a
    root = TreeNode.new(4)
    root.color = BLACK
    root.left = TreeNode.new(2)
    root.right = TreeNode.new(8)
    root.left.left = TreeNode.new(1)
    root.left.right = TreeNode.new(3)
    root.right.left = TreeNode.new(6)
    assert_equal([1, 2, 3, 4, 6, 8], root.to_a)
  end

  def test_get_min_node
    root = TreeNode.new(8)
    root.left = TreeNode.new(5)
    root.right = TreeNode.new(14)
    root.left.left = TreeNode.new(3)
    root.left.right = TreeNode.new(7)
    root.right.left = TreeNode.new(12)
    assert_equal(3, root.min_node.val)
  end

  def test_delete_min_node_with_out_rotation
    root = TreeNode.new(8)
    root.color = BLACK
    root.left = TreeNode.new(5)
    root.left.color = BLACK
    root.right = TreeNode.new(14)
    root.right.color = BLACK
    root.left.left = TreeNode.new(3)
    root.right.left = TreeNode.new(12)
    root.delete_min
    assert_equal(nil, root.left.left.val)
  end

  def test_delete_min_node_with_rotation
    root = TreeNode.new(8)
    root.color = BLACK
    root.left = TreeNode.new(5)
    root.left.color = BLACK
    root.right = TreeNode.new(14)
    root.right.color = BLACK
    root.left.left = TreeNode.new(3)
    root.left.right = TreeNode.new(7)
    root.right.left = TreeNode.new(12)
    root.delete_min
    assert_equal(5, root.left.left.val)
    assert_equal(nil, root.left.right.val)
  end

  def test_delete
    root = TreeNode.new(8)
    root.color = BLACK
    root.left = TreeNode.new(5)
    root.left.color = BLACK
    root.right = TreeNode.new(14)
    root.right.color = BLACK
    root.left.left = TreeNode.new(3)
    root.left.right = TreeNode.new(7)
    root.right.left = TreeNode.new(12)
    root.right.right = TreeNode.new(16)
    print "\n\n"
    root.print_node([root], 1, root.max_level)
    root.delete(16)
    root.print_node([root], 1, root.max_level)
    assert_equal(nil, root.right.right.val)
  end
end
