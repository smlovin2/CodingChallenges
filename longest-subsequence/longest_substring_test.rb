require 'minitest/autorun'
require_relative 'longest_subsequence'

class LongestSubsequenceTest < Minitest::Test
  def test_nil_case
  	longest = LongestSubsequence.find_brute_force(nil, nil)
  	assert_equal nil, longest
  end

  def test_no_common_subsequences
  	longest = LongestSubsequence.find_brute_force("a", "b")
  	assert_equal nil, longest
  end

  def test_short_string
  	longest = LongestSubsequence.find_brute_force("ABCDAF", "ACBCF")
  	assert_equal "ABCF", longest.chars.sort.join
  end

  def test_long_string
    longest = LongestSubsequence.find_brute_force("ABCAACBDDAFE", "ABCDEFDACD")
    assert_equal "ABCACD", longest
  end

  def test_nil_case_dynamic
  	longest = LongestSubsequence.dynamic_find(nil, nil)
  	assert_equal nil, longest
  end

  def test_no_common_subsequences_dynamic
  	longest = LongestSubsequence.dynamic_find("a", "b")
  	assert_equal nil, longest
  end

  def test_short_string_dynamic
  	longest = LongestSubsequence.dynamic_find("ABCDAF", "ACBCF")
  	assert_equal "ABCF", longest.chars.sort.join
  end

  def test_long_string
    longest = LongestSubsequence.dynamic_find("AABCDBDCACDBDACDDBBBDCD", "BCDABBBBDCADCDACDBAAADC")
    assert_equal "BCDBDCACDACDBDC", longest
  end

end
