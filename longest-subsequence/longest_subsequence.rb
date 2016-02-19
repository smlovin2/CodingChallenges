module LongestSubsequence

	def self.find_brute_force(first, second)
		if first.nil? || second.nil?
			return
		end

		#Find all subsequences for first
		first_subsequences = get_subsequences(first.chars)
		first_subsequences = first_subsequences.map &:join

		#Find all subsequences for second
		second_subsequences = get_subsequences(second.chars)
		second_subsequences = second_subsequences.map &:join

		# puts "First subsequences: #{first_subsequences}"
		# print "\n\n"
		# puts "Second subsequences: #{second_subsequences}"

		longest = ""

		first_subsequences.each do |seq1|
			second_subsequences.each do |seq2|
				if seq1 == seq2 && seq1.length > longest.length
					longest = seq1
				end
			end
		end

		if longest.empty?
			return
		else
			longest
		end
	end

	def self.dynamic_find(first, second)
		if first.nil? || second.nil?
			return
		end

		matrix = Array.new(first.length+1, 0) { Array.new(second.length+1, 0) }

		first.chars.each_with_index do |char1, i|
			second.chars.each_with_index do |char2, j|
				if char1 == char2
					matrix[i+1][j+1] = matrix[i][j] + 1
				else
					matrix[i+1][j+1] = [matrix[i][j+1], matrix[i+1][j]].max
				end
			end
		end

		if matrix[first.length][second.length] == 0
			return
		end

		longest_subsequence = ""
		i = first.length
		j = second.length

		while i > 0 && j > 0 do
			if matrix[i][j] == matrix[i][j-1]
				j = j -1
			elsif matrix[i][j] == matrix[i-1][j]
				i = i - 1
			else
				longest_subsequence.prepend(first[i-1])
				i = i - 1
				j = j - 1
			end
		end

		longest_subsequence
	end

	def self.get_subsequences(chars)
		return [chars] if chars.empty?

		top = chars.pop
		subset = get_subsequences(chars)
		subset | subset.map {|x| x + [top]}
	end
end
