module Factorial

  def self.of(number)
    # if number == 1 || number.nil?
    #   number
    # else
    #   number * of(number -1)
    # end

    if number.nil?
      nil
    else
      (2..number).reduce(1) {|acc, n| acc * n}
    end
  end


end
