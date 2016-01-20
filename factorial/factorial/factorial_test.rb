require 'minitest/autorun'
require_relative 'factorial'

class FactorialTest < Minitest::Test

  def test_nil_case
    assert_equal nil, Factorial.of(nil)
  end

  def test_1_case
    assert_equal 1, Factorial.of(1)
  end

  def test_factorial
    assert_equal  6227020800, Factorial.of(13)
  end

end
