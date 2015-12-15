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
		# Find all the ones
		ones_coords = find_ones

		# Iterate over all the data points and see if they are within a manhattan distance of the 1's.
		# If they are then they become a one
		@data.each_with_index do |row, row_num|
      row.each_with_index do |element, column_num|
				ones_coords.each do |x,y|
					if manhattan_distance(column_num, row_num, x, y) <= distance
						@data[row_num][column_num] = 1
					end
				end
      end
    end
  end

  def find_ones
    # Iterates over @data to find all the 1's and then returns array of
    # coordinates
		coordinates = []
		@data.each_with_index do |row, y_coord|
      row.each_with_index do |element, x_coord|
        if element == 1
					coordinates <<  [x_coord, y_coord]
        end
      end
    end
		return coordinates
  end

  def manhattan_distance(x1, y1, x2, y2)
    (x2-x1).abs + (y2-y1).abs
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

image1.blur(1)
image2.blur(2)
image3.blur(3)

puts
puts "After Blur:"
image1.output_image
puts
image2.output_image
puts
image3.output_image
