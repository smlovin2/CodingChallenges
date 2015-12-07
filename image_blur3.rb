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
		# make a copy of our data
		tmp_data = Marshal.load(Marshal.dump(@data))
    # go through the data looking for 1's. When a 1 is found then travel the
    # manhattan distance around it in tmp_array and blur it.
    @data.each_index do |row_num|
      @data[row_num].each_index do |column_num|
        if @data[row_num][column_num] == 1
          travel(distance, row_num, column_num, tmp_data)
        end
      end
    end
		# assign the new blurred image to data
		@data = tmp_data
  end

  private
  def travel(distance, row, column, img)
    # chang it to a 1
    img[row][column] = 1

    # base case
    if distance == 0
      return
    end
    # go up as far as we can
    travel((distance-1), (row-1), (column), img) unless (row-1) < 0
    # next we go to the right
    travel((distance-1), (row), (column+1), img) unless (column+1) > (img[row].size-1)
    # go down
    travel((distance-1), (row+1), (column), img) unless (row+1) > (img.size-1)
    # go left
    travel((distance-1), (row), (column-1), img) unless (column-1) < 0
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
