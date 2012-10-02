# ValueObject 
A very small library to help you define and create immutable value
objects.  Mainly to reduce the amount of code I needed for ActiveRecord
`composed_of` classes.

## overview

Start off by creating a class which derives from `ValueObject::Base`.
Call `has_fields` to define a list of fields for the class.

    class Person < ValueObject::Base
      has_fields :height, :weight
    end

You can now create instances of this class with positional arguments:

    tom = Person.new(176, 75)
    dick = Person.new(160, 60)

Or with hashes:

    harry = Person.new(:height => 176, :weight => 75)
    
You can read their attributes, but you can't write them.

    tom.height           # => 176
    dick.weight          # => 60
    harry.height = 180   # => NoMethodError

You can test whether they are equal with `==` or `eql?`, which are
aliases.

    tom == dick       # => false
    tom.eql?(harry)   # => true

You can also create instances where all values are nil. This is the only
case in which a value object will return `true` for `empty?`

    harry.empty?                   # => false
    Person.new(nil, nil).empty?    # => true

You can even subclass them again to add more fields!

    class Superhero < Person
      has_fields :power
    end

    superman = Superhero.new('6 foot 3', '235 lbs', 'flies')

    superman.height     # => '6 foot 3'
    superman.weight     # => '235 lbs'
    superman.power      # => 'flies'

Create a hash from a value object by sending `to_hash`.

    superman.to_hash
    # => {:height => '6 foot 3',
          :weight => '325 lbs',
          :power => 'flies'}

`copy_with` allows you to make a copy of a value object while updating
certain attributes.

    superman.copy_with(:power => 'laser eyes')
    # => #<Superhero:0x3914490
        @height="6 foot 3",
        @weight="235 lbs",
        @power="laser eyes">

Value objects also define `hash`, which depends on the values of the
fields as well as the class of which they are an instance.

    superman.hash            # => 1160641176
