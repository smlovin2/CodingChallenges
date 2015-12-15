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

def reverse_list(list, previous=nil)

  # while list
  #   old_next = list.next_node
  #   list.next_node = previous
  #   previous = list
  #   list = old_next
  # end
  #
  # return previous

  # base case
  if list.nil?
    return previous
  end

  new_head = reverse_list(list.next_node, list)
  list.next_node = previous
  new_head
end

def is_infinite_linked_list

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
