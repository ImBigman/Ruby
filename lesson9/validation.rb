module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr, *args)
      @value = instance_variable_get("@#{attr}".to_sym)
      @name = "@#{attr}".to_sym
      @attr_hash = {}
      @attr_hash[@name] = *args
    end
  end

  module InstanceMethods

    def validate!
      self.class.instance_variable_get(:@attr_hash).each do |key, value|
        send "validate_#{value.first.to_s.sub(':', '')}", key, value.last
      end
    end

    def validate_presence(value, _)
      var = instance_variable_get(value)
      return unless var == '' || var.nil?

      raise StandardError, 'Argument is empty!'
    end

    def validate_format(value, args)
      raise StandardError, 'Wrong format of argument!' if instance_variable_get(value) !~ args
    end

    def validate_type(value, args)
      raise StandardError, 'Different types!' unless instance_variable_get(value).instance_of? args
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
