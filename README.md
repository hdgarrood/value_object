# ValueObject

A very small library to help you define and create immutable value objects.

## Why?

Mainly to reduce the amount of code I needed for ActiveRecord `composed_of` classes.
ValueObjects are designed with `composed_of` in mind; they will:

* happily accept `nil` for their fields, unlike [Values](https://github.com/tcrayford/Values).
* allow multiple levels of subclassing -- if you want a value object
which is like some other class of value object (ie, it has all of the other object's fields
and methods) but will some additional field or method, you can simply subclass it.

## How to use

Require it

    require 'value_object'

Subclass it


    class Person < ValueObject::Base
      has_fields :height, :weight
    end

Create a value object with positional arguments

    tom = Person.new(176, 75)
    dick = Person.new(160, 60)

Create a value object with a hash

    harry = Person.new(:height => 176, :weight => 75)
    
Read their attributes

    tom.height        # => 176
    dick.weight       # => 60

Test whether value objects are equal (note: #== and #eql? are aliases)

    tom == dick       # => false
    tom.eql?(harry)   # => true

Test for emptiness

    Person.new(nil, nil).empty?    # => true

You can even subclass them again!

    class Superhero < Person
      has_fields :power
    end

    superman = Superhero.new('6 foot 3', '235 lbs', 'flies')

    superman.height     # => '6 foot 3'
    superman.weight     # => '235 lbs'
    superman.power      # => 'flies'

Turn them into hashes

    superman.to_hash
    # => {:height => '6 foot 3',
          :weight => '325 lbs',
          :power => 'flies'}

Make copies by passing a hash of updated attributes

    superman.copy_with(:power => 'laser eyes')
    # => #<Superhero:0x3914490
        @height="6 foot 3",
        @weight="235 lbs",
        @power="laser eyes"
    >

Hash them. A hash depends on the both the object's class and the
attribute values for that object, so that if o1 and o2 are both value
objects, and o1.eql?(o2), then o1.hash == o2.hash

    superman.hash
    # => 1160641176
