require 'minitest/autorun'
require 'benchmark'

module Collatz
  @known_sequences = {}

  def self.get_sequence(num)
    if num == 1
      num
    elsif num.even?
      get_sequence(num/2) + 1
    else
      get_sequence(3*num + 1) + 1
    end
  end

  def self.get_sequence_with_memoization(num)
    if @known_sequences.has_key?(num)
      @known_sequences[num]
    elsif num == 1
      num
    elsif num.even?
      @known_sequences[num] = get_sequence(num/2) + 1
    else
      @known_sequences[num] = get_sequence(3*num + 1) + 1
    end
  end
end

def longest_collatz_squence_for_nums_upto_one_million
  number = 0
  longest_length = 0
  1.upto(1000000) do |n|
    new_length = Collatz.get_sequence(n)
    if new_length > longest_length
      number = n
      longest_length = new_length
    end
  end

  puts "#{number} has the longest length of #{longest_length}"
end

def longest_collatz_squence_for_nums_upto_one_million_with_memoization
  number = 0
  longest_length = 0
  1.upto(1000000) do |n|
    new_length = Collatz.get_sequence_with_memoization(n)
    if new_length > longest_length
      number = n
      longest_length = new_length
    end
  end

  puts "#{number} has the longest length of #{longest_length}"
end

class TestCollatz < MiniTest::Unit::TestCase

  def test_sequence_for_one
    assert_equal 1, Collatz.get_sequence(1)
  end

  def test_sequence_for_two
    assert_equal 2, Collatz.get_sequence(2)
  end

  def test_sequence_for_three
    assert_equal 8, Collatz.get_sequence(3)
  end

  def test_momoization
    assert_equal 8, Collatz.get_sequence_with_memoization(3)
    assert_equal 8, Collatz.get_sequence_with_memoization(3)
  end
end

Benchmark.bmbm do |x|
  x.report("without_memoiaztion") {longest_collatz_squence_for_nums_upto_one_million}
  x.report("with_memoization") {longest_collatz_squence_for_nums_upto_one_million_with_memoization}
end
