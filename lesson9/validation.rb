module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validators

    def all_validators(name, type, attribute)
      @validators ||= []
      @validators << { name: name,
                       validation_type: type,
                       attributes: attribute }
    end

    def validate(attr, *args)
      name = "@#{attr}".to_sym
      type = args[0].to_s.sub(':', '')
      attribute = args[1]
      all_validators(name, type, attribute)
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validators).each do |elem|
        send "validate_#{elem[:validation_type]}", elem[:name], elem[:attributes]
      end
    end

    def validate_presence(value, _)
      var = instance_variable_get(value)
      return unless var == '' || var.nil?

      raise StandardError, 'Validate_presence: Argument is empty!'
    end

    def validate_format(value, args)
      return unless instance_variable_get(value) !~ args

      raise StandardError, 'Validate_format: Wrong format of argument!'
    end

    def validate_type(value, args)
      return if instance_variable_get(value).instance_of? args

      raise StandardError, 'Validate_type: Different types!'
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
