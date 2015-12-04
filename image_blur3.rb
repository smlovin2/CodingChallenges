class Image
	def initialize (data)
		@data = data
	end

	def output_image
		@data.each do |row|
			puts row.join
		end
	end

  def blur(distance)
    @data.each_index do |row_num|
      @data[row_num].each_index do |column_num|
        if @data[row_num][column_num] == 1
          puts "Found a 1! Let's travel!"
          travel(distance, row_num, column_num, 1)
          puts
        elsif @data[row_num][column_num] == 0.5
           @data[row_num][column_num] = 1
        end
      end
    end
  end

  private
  def travel(distance, row, column, val)
    puts "Distance: #{distance}, You are at row: #{row} column: #{column}"

    # make it a 1 or 0.5
    @data[row][column] = val

    # base case
    if distance == 0
      return
    end
    # go up as far as we can
    travel((distance-1), (row-1), (column), 1) unless (row-1) < 0 || @data[row-1][column] == 1
    # next we go to the right
    travel((distance-1), (row), (column+1), 0.5) unless (column+1) > (@data[row].size-1) || @data[row][column+1] == 1 || @data[row][column+1] == 0.5
    # go down
    travel((distance-1), (row+1), (column), 0.5) unless (row+1) > (@data.size-1) || @data[row+1][column] == 1 || @data[row+1][column] == 0.5
    # go left
    travel((distance -1), (row), (column-1), 1) unless (column-1) < 0 || @data[row][column-1] == 1
  end
end

image1 = Image.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])

image2 = Image.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])

image3 = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 1]
])

puts "Before Blur:"
image1.output_image
puts
image2.output_image
puts
image3.output_image
puts "Blur image1"
image1.blur(1)
puts
puts "Blur image2"
image2.blur(2)
puts
puts "Blur image3"
image3.blur(3)
puts
puts "After Blur:"
image1.output_image
puts
image2.output_image
puts
image3.output_image
