require 'minitest/autorun'
require 'left_leaning_red_black_tree'
module LeftLeaningRedBlackTree
  class TestLLRB < MiniTest::Unit::TestCase

    def test_empty_tree
      tree = Tree.new
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
      tree = Tree.new
      tree.insert(7)
      assert_equal(7, tree.root.val)
      assert_equal(BLACK, tree.root.color)
    end

    def test_insert_lesser_node
      tree = Tree.new
      tree.insert(7)
      tree.insert(5)
      assert_equal(5, tree.root.left.val)
      assert_equal(RED, tree.root.left.color)
    end

    def test_insert_greater_node_without_rotation
      tree = Tree.new
      tree.insert(7)
      tree.insert(5)
      tree.insert(10)
      print "\n\n"
      tree.root.print_node([tree.root], 1, tree.root.max_level)
      assert_equal(10, tree.root.right.val)
      assert_equal(RED, tree.root.right.color)
    end

    def test_insert_greater_node_with_rotation
      tree = Tree.new
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
      #print "\n\n"
      #root.print_node([root], 1, root.max_level)
      root.delete(16)
      #root.print_node([root], 1, root.max_level)
      assert_equal(nil, root.right.right.val)
    end
  end
end
