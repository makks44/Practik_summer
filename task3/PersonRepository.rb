require 'test/unit'
require_relative 'Person'
require_relative 'PersonRepository'

class PersonRepositoryTest < Test::Unit::TestCase
  def setup
    @repository = PersonRepository.new
    @person1 = Person.new('Alice', 'Smith', '1990-03-15', '111111111')
    @person2 = Person.new('Bob', 'Johnson', '1985-08-20', '222222222')
  end

  def test_add_person_to_repository
    @repository.add_person(@person1)
    assert_equal([@person1], @repository.people)

    assert_raise(ArgumentError) { @repository.add_person('not a person') }
    assert_raise(PersonAlreadyExist) { @repository.add_person(@person1) }
  end

  def test_edit_person_in_repository_by_inn
    @repository.add_person(@person1)
    @repository.edit_person_by_inn('111111111', 'Eve', 'Brown', '1995-12-10')
    assert_equal('Eve', @person1.first_name)
    assert_equal('Brown', @person1.last_name)
    assert_equal('1995-12-10', @person1.birth_date)

    assert_raise(PersonNotFoundError) { @repository.edit_person_by_inn('999999999', 'Jack', 'Smith', '1985-03-20') }
  end

  def test_delete_person_in_repository_by_inn
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    @repository.delete_person_by_inn('111111111')
    assert_equal([@person2], @repository.people)

    assert_raise(PersonNotFoundError) { @repository.delete_person_by_inn('111111111') }
  end

  def test_get_person_by_inn
    @repository.add_person(@person1)
    assert_equal(@person1, @repository.get_by_inn('111111111'))
    assert_nil(@repository.get_by_inn('999999999'))
  end

  def test_get_person_by_part_name
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    assert_equal([@person1, @person2], @repository.get_by_part_name('s'))
    assert_equal([@person2], @repository.get_by_part_name('Bob'))
  end

  def test_get_person_by_date_range
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    assert_equal([@person1], @repository.get_by_date_range(nil, '1994-01-01'))
    assert_equal([@person2], @repository.get_by_date_range('1986-01-01', nil))
    assert_equal([@person1, @person2], @repository.get_by_date_range(nil, nil))
  end
end
