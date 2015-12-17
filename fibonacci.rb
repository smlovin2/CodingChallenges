require 'minitest/autorun'
require 'benchmark'

module Fibonacci
  def self.recursive_fib(n)
    # base case
    if n == 0 || n == 1
      return n
    end

    fib_num = recursive_fib(n-1) + recursive_fib(n-2)
  end

  def self.iterative_fib(n)
    if n == 0 || n == 1
      return n
    end

    fib_num = 0
    prev_1 = 0
    prev_2 = 1
    for i in 2..n
      fib_num = prev_1 + prev_2
      prev_1 = prev_2
      prev_2 = fib_num
    end

    fib_num
  end
end

class TestFibonacci < MiniTest::Unit::TestCase

  def test_recursive_fib
    assert_equal 34, Fibonacci.recursive_fib(9)
  end

  def test_iterative_fib
    assert_equal 21, Fibonacci.iterative_fib(8)
  end

  def test_recursive_fib_zero
    assert_equal 0, Fibonacci.recursive_fib(0)
  end

  def test_recursive_fib_one
    assert_equal 1, Fibonacci.recursive_fib(1)
  end

  def test_iterative_fib_zero
    assert_equal 0, Fibonacci.iterative_fib(0)
  end

  def test_iterative_fib_zero
    assert_equal 1, Fibonacci.iterative_fib(1)
  end
end

num = 35
Benchmark.bm do |x|
  x.report("recursive_fib") {Fibonacci.recursive_fib(num)}
  x.report("iterative_fib") {Fibonacci.iterative_fib(num)}
end
