class Tree
  attr_accessor :payload, :children

  def initialize(payload, children)
    @payload = payload
    @children = children
  end

  def print_node
    print "Payload: #{@payload}\n"
    print "Children:\n"
    @children.each_with_index do |child, child_num|
      print "\tChild #{child_num}: #{child.payload}\n"
    end
    print "\n"
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(item)
    @queue.push(item)
  end

  def dequeue
    @queue.shift
  end

  def is_empty?
    return @queue.size == 0
  end
end

def depth_first(goal, node)

  node.print_node

  # base case
  if node.payload == goal
    return node
  end

  ret_val = nil

  # go down through each of the children till you find the goal
  node.children.each do |child|
    ret_val = depth_first(goal, child)

    # did we find the node? If so then break and return, otherwise keep looking
    if !ret_val.nil?
      break
    end
  end

  # return the correct node if found, if not found return nil
  ret_val
end

def breadth_first(goal, trunk)
  # Check if the trunk is the node we are looking for
  if trunk.payload == goal
    return trunk
  end

  # If not then create a queue and add the trunk to the start of the queue
  queue = Queue.new
  queue.enqueue(trunk)

  # While we still have stuff in the queue go through each item in the queue
  # and check if it's children are the correct node. If not then add them
  # to the queue so we can look at their children
  while !queue.is_empty?
    current_node = queue.dequeue

    current_node.print_node

    current_node.children.each do |child|
      if child.payload == goal
        return child
      end
      queue.enqueue(child)
    end
  end
end

# The "Leafs" of a tree, elements that have no children
fifth_node = Tree.new(5, [])
eleventh_node = Tree.new(11, [])
fourth_node = Tree.new(4, [])

# The "Branches" of the tree
ninth_node = Tree.new(9, [fourth_node])
sixth_node = Tree.new(6, [fifth_node, eleventh_node])
seventh_node = Tree.new(7, [sixth_node])
fifth_node = Tree.new(5, [ninth_node])

# The "Trunk" of the tree
trunk = Tree.new(2, [seventh_node, fifth_node])

found_node = depth_first(11, trunk)
puts "Found Node: "
found_node.print_node

print "\n==========================\n\n"
found_node = breadth_first(11, trunk)
puts "Found Node: "
found_node.print_node
