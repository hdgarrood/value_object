require 'test/unit'

class ValueObjectTest < Test::Unit::TestCase
  def setup
    @person_class = Class.new(ValueObject::Base)
    @person_class.has_fields :height, :weight
  end

  test "creates people properly with positional arguments" do
    p = @person_class.new(176, 75)
    assert_equal(176, p.height)
    assert_equal(75, p.weight)
  end

  test "creates people properly with hashes" do
    p = @person_class.new(:height => 176, :weight => 75)
    assert_equal(176, p.height)
    assert_equal(75, p.weight)
  end

  test "equality of people" do
    p1 = @person_class.new(176, 75)
    p2 = @person_class.new(176, 75)
    assert_equal(p1, p2)
  end

  test "inequality of people" do
    p1 = @person_class.new(180, 75)
    p2 = @person_class.new(176, 89)
    assert_not_equal(p1, p2)
  end

  test "emptiness of people" do
    assert_equal(true, @person_class.new(nil, nil).empty?)
  end
end
