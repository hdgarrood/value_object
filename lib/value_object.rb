require "value_object/version"
require "active_support/core_ext/class/attribute"

module ValueObject
  class Base
    class_attribute :fields
    self.fields = []

    class << self
      def has_fields(*args)
        attr_reader *args
        self.fields += args
      end
    end

    def fields
      self.class.fields
    end

    def initialize(*args)
      if args.length == 1 && args[0].is_a?(Hash)
        fields.each { |f| instance_variable_set "@#{f}", args[0][f] }
      else
        fields.each_with_index { |f, idx| instance_variable_set "@#{f}", args[idx] }
      end
    end

    def eql?(other)
      return false if self.class != other.class
      fields.all? { |f| send(f) == other.send(f) }
    end

    def ==(other)
      eql?(other)
    end

    def empty?
      fields.all? { |f| send(f).nil? }
    end
  end
end
