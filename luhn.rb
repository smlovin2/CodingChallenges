require 'minitest/autorun'

class Integer
  def to_single_digit
    if self >= 10
      self - 9
    else
      self
    end
  end
end

module Luhn
  def self.is_valid?(number)
    digits = number.to_s.split("").map(&:to_i)
    digits = digits.reverse.each_with_index.map { |digit, index|
      double_if_odd(digit, index)
    }.map { |digit|
      digit.to_single_digit
    }
    sum = digits.inject(:+)

    sum % 10 == 0
  end

  private

  def self.double_if_odd(digit, index)
    if index.odd?
      digit * 2
    else
      digit
    end
  end

  def self.to_single_digit(digit)
    if digit >= 10
      digit - 9
    else
      digit
    end
  end
end

class TestLuhn < MiniTest::Unit::TestCase

  def test_luhn_valid
    assert Luhn.is_valid?(4194560385008504)
  end

  def test_luhn_invalid
    assert ! Luhn.is_valid?(4194560385008505)
  end

  def test_luhn_valid2
    assert Luhn.is_valid?(377681478627336), "Check step two: Did you start at the right?"
  end

  def test_luhn_invalid2
    assert ! Luhn.is_valid?(377681478627337), "Check step two: Did you start at the right?"
  end

end
