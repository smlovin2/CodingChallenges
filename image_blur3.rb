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
    @data.each_index do |row_num|
      @data[row_num].each_index do |column_num|
        if @data[row_num][column_num] == 1
          @data[row_num-1][column_num] = 1 unless row_num-1 < 0
          @data[row_num+1][column_num] = 0.5 unless row_num+1 > (@data.size - 1)
          @data[row_num][column_num-1] = 1 unless column_num-1 < 0
          @data[row_num][column_num+1] = 0.5 unless column_num+1 > (@data[row_num].size - 1)
        elsif @data[row_num][column_num] == 0.5
          @data[row_num][column_num] = 1
        end
      end
    end
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
