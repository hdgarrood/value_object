# ValueObject
A very small library to help you define and create immutable value
objects.  Mainly to reduce the amount of code I needed for ActiveRecord
`composed_of` classes.

## overview

Start off by creating a class which derives from `ValueObject::Base`.
Call `has_fields` to define a list of fields for the class.

    class Route < ValueObject::Base
      has_fields :from, :to
    end

You can now create instances of this class with positional arguments:

    m1_motorway    = Route.new("London", "Leeds")
    channel_tunnel = Route.new("Calais", "Dover")

Or with hashes:

    route_66 = Route.new(:from => "Santa Monica", :to => "Chicago")

You can read their attributes, but you can't write them.

    m1_motorway.from     # => "London"
    channel_tunnel.to    # => "Dover"
    route_66.from = "IL" # => NoMethodError

You can test whether they are equal with `==` or `eql?`, which are
aliases.

    m1_motorway == channel_tunnel                 # => false
    m1_motorway.eql?(Route.new("London", "Leeds)) # => true

You can also create instances where all values are nil. Objects like this will
return `true` when sent the message `empty?` (and will)

    m1_motorway.empty?         # => false
    Route.new(nil, nil).empty? # => true

You can even subclass them again to add more fields!

    class Railway < Route
      has_fields :serviced_by
    end

    a_railway = Railway.new("Aberdeen", "Inverness", "ScotRail")

    a_railway.height     # => '6 foot 3'
    a_railway.weight     # => '235 lbs'
    a_railway.power      # => 'flies'

Create a hash from a value object by sending `to_hash`.

    a_railway.to_hash
    # => {
           :from        => "Aberdeen",
           :to          => "Inverness",
           :serviced_by => "ScotRail"
         }

`copy_with` allows you to make a copy of a value object while updating
certain attributes.

    a_railway.copy_with(:serviced_by => "Virgin")
    # => #<Railway:0x3914490
        @from="Aberdeen",
        @to="Inverness",
        @serviced_by="Virgin">

Value objects also define `hash`, which depends on the values of the
fields as well as the class of which they are an instance.

    a_railway.hash            # => 1160641176
