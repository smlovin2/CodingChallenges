class Image
	def initialize (data)
		@data = data
	end

	def output_image
		@data.each do |row|
			puts row.join
		end
	end

  def blur
		tmp_array = Marshal.load(Marshal.dump(@data))
    @data.each_with_index do |row, row_num|
      row.each_with_index do |element, column_num|
        if element == 1
					tmp_array[row_num][column_num] = 1
          tmp_array[row_num-1][column_num] = 1 unless row_num-1 < 0
          tmp_array[row_num+1][column_num] = 1 unless row_num+1 > (@data.size-1)
          tmp_array[row_num][column_num-1] = 1 unless column_num-1 < 0
          tmp_array[row_num][column_num+1] = 1 unless column_num+1 > (@data[row_num].size-1)
        end
      end
    end
		@data = tmp_array
  end

  def find_ones
    # Iterates over @data to find all the 1's and then returns array of
    # coordinates
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
  [0, 0, 1, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])

image3 = Image.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [1, 0, 0, 0],
  [0, 0, 0, 0]
])

puts "Before Blur:"
image1.output_image
puts
image2.output_image
puts
image3.output_image
image1.blur
image2.blur
image3.blur
puts
puts "After Blur:"
image1.output_image
puts
image2.output_image
puts
image3.output_image
