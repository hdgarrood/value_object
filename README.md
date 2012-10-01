# ValueObject

A very small library to help you create value objects.

## Example use

    # subclass it
    class Person < ValueObject
      has_fields :height, :weight
    end

    # create a value object with positional arguments
    p1 = Person.new(176, 75)
    p2 = Person.new(160, 60)

    # create a value object with a hash
    p3 = Person.new(:height => 176, :weight => 75)

    # test whether value objects are equal
    p1 == p2      #=> false
    p1 == p3      #=> true

    # test for emptiness
    Person.new(nil, nil).empty?    #=> true

    # you can even subclass them again!
    class Superhero < Person
      has_fields :power
    end

    superman = Superhero.new('6 foot 3', '235 lbs', 'flies')

    superman.height     # => '6 foot 3'
    superman.weight     # => '235 lbs'
    superman.power      # => 'flies'
