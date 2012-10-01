require "value_object/version"
require "activesupport/core_ext/class/attribute"

class ValueObject
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

  def ==(other)
    fields.all? { |f| send(f) == other.send(f) }
  end

  def empty?
    fields.all? { |f| send(f).nil? }
  end
end
