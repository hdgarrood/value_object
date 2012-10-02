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
    assert p1.eql?(p2), "p1 should #eql? p2"
  end

  def test_inequality_of_people
    p1 = @person_class.new(180, 75)
    p2 = @person_class.new(176, 89)
    assert_not_equal(p1, p2)
  end

  def test_emptiness_of_people
    assert_equal(true, @person_class.new(nil, nil).empty?)
  end

  def test_can_subclass_subclasses
    superhero_class = Class.new(@person_class)
    superhero_class.has_fields :powers

    superman = superhero_class.new('6 foot 3',
                                   '235 lbs',
                                   ['flies', 'laser eyes', 'really strong'])
    assert_equal('6 foot 3', superman.height)
    assert_equal('235 lbs', superman.weight)
    assert_equal('flies', superman.powers[0])
  end

  def test_hashes_are_equal_if_people_are_equal
    p1 = @person_class.new(150, 50)
    p2 = @person_class.new(150, 50)
    assert_equal(p1.hash, p2.hash)
  end

  def test_hashes_are_not_equal_if_people_are_not_equal
    p1 = @person_class.new(150, 50)
    p2 = @person_class.new(200, 50)
    assert_not_equal(p1.hash, p2.hash)
  end

  def test_can_copy_value_objects_with_new_attributes
    p1 = @person_class.new(175, 75)
    p2 = @person_class.new(175, 80)
    assert_equal(p2, p1.copy_with(:weight => 80))
  end

  def test_turning_value_objects_into_hashes
    p = @person_class.new(175, 75)
    p_hash = {:height => 175, :weight => 75}
    assert_equal(p_hash, p.to_hash)
  end
end
