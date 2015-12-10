class LinkedListNode
  attr_accessor :value, :next_node

  def initialize(value, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

def print_values(list_node)
  print "#{list_node.value} --> "
  if list_node.next_node.nil?
    print "nil\n"
    return
  else
    print_values(list_node.next_node)
  end
end

class Stack
  attr_reader :data

  def initialize
    @data = nil
  end

  # Push a value onto the stack
  def push(value)
    @data = LinkedListNode.new(value, @data)
  end

  # Pop an item off the stack.
  # Remove the last item that was pushed onto the
  # stack and return the value to the user
  def pop
    # Get the value of the last node added
    ret_val = @data.value

    # Pop off that last(top) item and make the next one
    # the new top of the stack
    @data = @data.next_node

    return ret_val
  end
end

def reverse_list(list)
  stack = Stack.new

  while list
    stack.push(list.value)
    list = list.next_node
  end

  return stack.data
end

node1 = LinkedListNode.new(37)
node2 = LinkedListNode.new(99, node1)
node3 = LinkedListNode.new(12, node2)

print_values(node3)

puts "-----------"

revlist = reverse_list(node3)

print_values(revlist)

puts "\n------- NEW LIST --------\n\n"

node1 = LinkedListNode.new(105)
node2 = LinkedListNode.new(42, node1)
node3 = LinkedListNode.new(10, node2)
node4 = LinkedListNode.new(1, node3)
node5 = LinkedListNode.new(777, node4)
node6 = LinkedListNode.new(22, node5)

print_values(node6)

puts "-----------"

revlist = reverse_list(node6)

print_values(revlist)
