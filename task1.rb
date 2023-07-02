require 'date'

module Validation
  def self.valid_name?(string)
    return false if string.length > 40

    pattern = /^[a-zA-Z]+-[a-zA-Z]+$/
    return pattern.match?(string)
  end

  def self.valid_inn?(string)
    pattern = /^[A-Z]{2}\d{10}$/
    return pattern.match?(string)
  end

  def self.after_date?(date)
    return date <= Date.today
  end
end


puts Validation.valid_name?("Maks-Yo")  # true
puts Validation.valid_name?("Maks Yo")  # false 
puts Validation.valid_name?("VeryLongNameThatExceedsTheMaxLengthLimit")  # false 

puts Validation.valid_inn?("AB1234567890")  # true
puts Validation.valid_inn?("AB123")  # false 
puts Validation.valid_inn?("abc1234567890")  # false 

puts Validation.after_date?(Date.parse("1991-09-29"))  # true
puts Validation.after_date?(Date.today)  # true
puts Validation.after_date?(Date.parse("2222-03-13"))  # false 