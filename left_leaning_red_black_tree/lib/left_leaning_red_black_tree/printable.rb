module LeftLeaningRedBlackTree
  module Printable
    def print_node(nodes, level, max_level)
      if nodes.empty? || all_elements_nil?(nodes)
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
            new_nodes << NullNode.new
            new_nodes << NullNode.new
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
      [@left.max_level, @right.max_level].max + 1
    end

    def all_elements_nil?(nodes)
      nodes.each do |node|
        if !node.null?
          return false
        end
      end

      true
    end
  end
end
