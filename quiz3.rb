class ChristmasTree
  attr_accessor :lit

  # create the ChristmasTree (assume its a real tree if not specified)
  def initialize(size, real=true, prelit=false)
    @size = size
    @real = real
    @lit = prelit

    # new ChristmasTree's are undecorated and have no presents under them yet
    @ornaments = []
    @num_presents = 0
  end

  # add decorations and or lights to the tree, if not specifed we assume that
  # lights are put on the tree
  def decortate(ornaments, lights=true)
    # Add the ornaments
    @ornaments = ornaments

    # If the tree wasn't already prelit and lights were added then the tree is lit
    if(!@lit)
      @lit = lights
    end
  end

  def remove_ornament(ornament)
    @ornaments.delete(ornament)
  end

  def place_a_present
    @num_presents += 1
  end

  def open_presents
    @num_presents = 0
  end

  def observe_tree
    puts "============================="
    puts "Your Tree:"
    puts "Is #{@size} feet tall"
    if @real
      puts "Is Real"
    else
      puts "Is Fake"
    end
    puts "Has #{@ornaments.size} ornament(s) on it"
    puts "Ornaments: #{@ornaments.inspect}"
    if @lit
      puts "Is lit"
    else
      puts "Is not lit"
    end
    puts "Has #{@num_presents} presents under it"
    print "\n"
  end
end

my_tree = ChristmasTree.new(8, true, false)
my_tree.observe_tree
my_ornaments = ["star", "angel", "snowflake", "santa head", "red globe", "green globe", "snowman"]
my_tree.decortate(my_ornaments, true)
my_tree.observe_tree
for i in 0..9
  my_tree.place_a_present
end
my_tree.observe_tree
my_tree.remove_ornament("star")
my_tree.observe_tree
my_tree.open_presents
my_tree.lit = false
my_tree.observe_tree
