require 'date'

module ConsoleInput
  module_function

  def get_string(prompt)
    loop do
      print prompt
      input = gets.chomp
      return input unless input.empty?
    end
  end

  def get_integer(prompt)
    loop do
      print prompt
      input = gets.chomp
      return input.to_i if input.match?(/\A\d+\z/)
    end
  end

  def get_float(prompt)
    loop do
      print prompt
      input = gets.chomp
      return input.to_f if input.match?(/\A\d+(\.\d+)?\z/)
    end
  end

  def get_date(prompt)
    loop do
      print prompt
      input = gets.chomp
      return Date.parse(input) rescue nil
    end
  end

  def get_datetime(prompt)
    loop do
      print prompt
      input = gets.chomp
      return DateTime.parse(input) rescue nil
    end
  end

  def get_bool(prompt)
    loop do
      print prompt
      input = gets.chomp.downcase
      return true if input == 'y' || input == 'yes'
      return false if input == 'n' || input == 'no'
    end
  end
end