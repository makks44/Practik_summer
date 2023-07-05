require_relative 'Person'
require_relative 'Errors'

class PersonRepository
  attr_reader :people

  def initialize
    @people = []
  end

  def add_person(person)
    raise ArgumentError, 'Person must be a member of Person class' unless person.is_a?(Person)

    if @people.any? { |p| p.inn == person.inn }
      raise PersonAlreadyExist.new(person.inn)
    else
      @people << person
    end
  end

  def edit_person_by_inn(inn, new_first_name, new_last_name, new_birth_date)
    person = get_by_inn(inn)
    raise PersonNotFoundError.new(inn) unless person

    person.first_name = new_first_name
    person.last_name = new_last_name
    person.birth_date = new_birth_date
  end

  def delete_person_by_inn(inn)
    person = get_by_inn(inn)
    raise PersonNotFoundError.new(inn) unless person

    @people.delete(person)
  end

  def get_by_inn(inn)
    @people.find { |person| person.inn == inn }
  end

  def get_by_part_name(name_part)
    name_part = name_part.downcase

    @people.select do |person|
      person.first_name.downcase.include?(name_part) || person.last_name.downcase.include?(name_part)
    end
  end

  def get_by_date_range(date_from, date_to)
    @people.select do |person|
      birth_date = person.birth_date
      (date_from.nil? || birth_date >= date_from) &&
      (date_to.nil? || birth_date <= date_to)
    end
  end
end