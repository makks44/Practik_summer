require 'date'
require_relative 'ConsoleInput'
require_relative 'Validation'

class Person
  include ConsoleInput
  include Validation

  attr_reader :first_name, :last_name, :inn, :birth_date

  def initialize(first_name, last_name, inn, birth_date)
    self.first_name = first_name
    self.last_name = last_name
    self.inn = inn
    self.birth_date = birth_date
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    now = Date.today
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def to_s
    "#{full_name}, INN: #{inn}, Birth Date: #{birth_date.strftime('%Y-%m-%d')}"
  end

  def first_name=(new_first_name)
    validate_name(new_first_name, 'First Name')
    @first_name = new_first_name
  end

  def last_name=(new_last_name)
    validate_name(new_last_name, 'Last Name')
    @last_name = new_last_name
  end

  def inn=(new_inn)
    validate_inn(new_inn)
    @inn = new_inn
  end

  def birth_date=(new_birth_date)
    validate_birth_date(new_birth_date)
    @birth_date = Date.parse(new_birth_date)
  end

  private

  def validate_name(name, field_name)
    raise ArgumentError, "Invalid #{field_name}" unless valid_name?(name)
  end

  def validate_inn(inn)
    raise ArgumentError, 'Invalid INN' unless valid_inn?(inn)
  end

  def validate_birth_date(date)
    raise ArgumentError, 'Invalid birth date format' unless valid_date_format?(date)
    raise ArgumentError, 'Birth date must be in the past' unless valid_birth_date?(date)
  end
end
