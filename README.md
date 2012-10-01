# ValueObject

A very small library to help you create value objects.

## how to use

    # subclass it
    class Person < ValueObject
      has_fields :height, :weight
    end

    # create a value object with positional arguments
    tom = Person.new(176, 75)
    dick = Person.new(160, 60)

    # create a value object with a hash
    harry = Person.new(:height => 176, :weight => 75)

    # test whether value objects are equal
    tom == dick       #=> false
    tom == harry      #=> true

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
