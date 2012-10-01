require 'test/unit'
require 'value_object'

class ValueObjectTest < Test::Unit::TestCase
  def setup
    @person_class = Class.new(ValueObject::Base)
    @person_class.has_fields :height, :weight
  end

  def test_creates_people_properly_with_positional_arguments
    p = @person_class.new(176, 75)
    assert_equal(176, p.height)
    assert_equal(75, p.weight)
  end

  def test_creates_people_properly_with_hashes
    p = @person_class.new(:height => 176, :weight => 75)
    assert_equal(176, p.height)
    assert_equal(75, p.weight)
  end

  def test_equality_of_people
    p1 = @person_class.new(176, 75)
    p2 = @person_class.new(176, 75)
    assert_equal(p1, p2)
  end

  def test_inequality_of_people
    p1 = @person_class.new(180, 75)
    p2 = @person_class.new(176, 89)
    assert_not_equal(p1, p2)
  end

  def test_emptiness_of_people
    assert_equal(true, @person_class.new(nil, nil).empty?)
  end
end