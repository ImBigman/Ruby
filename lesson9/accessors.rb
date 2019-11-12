module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  # rubocop: disable Metrics/MethodLength
  module ClassMethods
    def attr_accessor_with_history(*names)
      history_arr = []
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_var_name = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get(history_var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(history_var_name, history_arr << instance_variable_get(var_name))
          "#{name} = #{instance_variable_set(var_name, value)}"
        end
      end
    end
    # rubocop: enable Metrics/MethodLength

    def strong_attr_accessor(var, var_class)
      var_name = "@#{var}".to_sym
      define_method(var) { instance_variable_get(var_name) }
      define_method("#{var}=".to_sym) do |value|
        raise TypeError if var_class != value.class.to_s

        "#{var} = #{instance_variable_set(var_name, value)}"
      end
    end
  end
end
