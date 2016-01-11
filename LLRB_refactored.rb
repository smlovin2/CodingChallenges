require 'minitest/autorun'

RED = true
BLACK = false

class LLRBTree
  attr_accessor :root

  def initialize
    @root = NullNode.new
  end

  def insert(val)
    @root.insert(val)
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
    maxLevel = root.maxLevel
    root.print_node(1, maxLevel)
  end

  private

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
      node = move_red_left(node)
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

  def red?
    @color
  end



  def flip_colors
    @color = !@color
    @left.color = !@left.color
    @right.color = !@right.color
  end

  def rotate_left
    new_parent_node = @right
    @right = new_parent_node.left
    new_parent_node.left = self
    new_parent_node.color = @color
    @color = RED
    new_parent_node
  end

  def rotate_right
    new_parent_node = @left
    @left = new_parent_node.right
    new_parent_node.right = self
    new_parent_nodecolor = @color
    @color = RED
    new_parent_node
  end

  def fix_up
    if @right.red? && !@left.red?
      rotate_left
    end
    if @left.red? && @left.left.red?
      rotate_right
    end

    self
  end

  def assign_val(val)
    @val = val
    @color = RED
    unless val.nil?
      @left = NullNode.new
      @right = NullNode.new
    end
  end

  def print(level, max_level)
    if @val.nil?
        return;

    int floor = maxLevel - level;
    int endgeLines = (int) Math.pow(2, (Math.max(floor - 1, 0)));
    int firstSpaces = (int) Math.pow(2, (floor)) - 1;
    int betweenSpaces = (int) Math.pow(2, (floor + 1)) - 1;

    BTreePrinter.printWhitespaces(firstSpaces);

    List<Node<T>> newNodes = new ArrayList<Node<T>>();
    for (Node<T> node : nodes) {
        if (node != null) {
            System.out.print(node.data);
            newNodes.add(node.left);
            newNodes.add(node.right);
        } else {
            newNodes.add(null);
            newNodes.add(null);
            System.out.print(" ");
        }

        BTreePrinter.printWhitespaces(betweenSpaces);
    }
    System.out.println("");

    for (int i = 1; i <= endgeLines; i++) {
        for (int j = 0; j < nodes.size(); j++) {
            BTreePrinter.printWhitespaces(firstSpaces - i);
            if (nodes.get(j) == null) {
                BTreePrinter.printWhitespaces(endgeLines + endgeLines + i + 1);
                continue;
            }

            if (nodes.get(j).left != null)
                System.out.print("/");
            else
                BTreePrinter.printWhitespaces(1);

            BTreePrinter.printWhitespaces(i + i - 1);

            if (nodes.get(j).right != null)
                System.out.print("\\");
            else
                BTreePrinter.printWhitespaces(1);

            BTreePrinter.printWhitespaces(endgeLines + endgeLines - i);
        }

        System.out.println("");
    }

    printNodeInternal(newNodes, level + 1, maxLevel);
  end
end

class NullNode < TreeNode
  def initialize
    super(nil)
    @color = BLACK
  end
end

    private static void printWhitespaces(int count) {
        for (int i = 0; i < count; i++)
            System.out.print(" ");
    }

    private static <T extends Comparable<?>> int maxLevel(Node<T> node) {
        if (node == null)
            return 0;

        return Math.max(BTreePrinter.maxLevel(node.left), BTreePrinter.maxLevel(node.right)) + 1;
    }

    private static <T> boolean isAllElementsNull(List<T> list) {
        for (Object object : list) {
            if (object != null)
                return false;
        }

        return true;
    }

}

class TestLLRB < MiniTest::Unit::TestCase

  def test_empty_tree
    tree = LLRBTree.new
    assert(tree.root)
  end

  def test_insert_one_node
    tree = LLRBTree.new
    tree.insert(7)
    assert_equal(7, tree.root.val)
    assert_equal(BLACK, tree.root.color)
  end

  def test_insert_lesser_node
    tree = LLRBTree.new
    tree.insert(7)
    tree.insert(5)
    assert(tree.root.left)
    assert_equal(5, tree.root.left.val)
    assert_equal(RED, tree.root.left.color)
  end

  def test_rotate_right
    root = TreeNode.new(1)
    root.color = BLACK
    root.left = TreeNode.new(2)
    root.right = TreeNode.new(3)
  end

end
