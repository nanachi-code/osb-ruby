module Internal
  class TypeError < StandardError; end
  Boolean = [TrueClass, FalseClass]
  def self.assert_type!(var, possible_types, param_name)
    if possible_types.is_a?(Array)
      valid = possible_types.any?{ |type| var.is_a?(type) }
      unless valid
        accepted_types = possible_types.first.name
        if possible_types.size > 1
          1..(possible_types.size - 1).each do |type|
            accepted_types + ' or ' + type.name
          end
        end

        raise TypeError, "Parameter #{param_name} expects type #{accepted_types}, got type #{var.class.name} instead." 
      end
    else
      type = possible_types
      unless var.is_a?(type)
        raise TypeError, "Parameter #{param_name} expects type #{type.name}, got type #{var.class.name} instead." 
      end
    end
  end    

  def self.assert_value!(var, possible_values, param_name)
    if possible_types.is_a?(Array)
      valid = possible_values.any?{ |value| var == value }
      unless valid
        accepted_values = possible_values.first
        if possible_values.size > 1
          1..(possible_values.size - 1).each do |value|
            accepted_values + ' or ' + value
          end
        end

        raise ArgumentError, "Parameter #{param_name} expects #{accepted_values}, got #{var} instead." 
      end
    elsif possible_values.is_a?(Range)
      valid = var >= possible_values.min && var <= possible_values.max
      unless valid
        raise ArgumentError, "Parameter #{param_name} expects value within #{possible_values.min} to #{possible_values.max}, got #{var} instead." 
      end
    else 
      unless var == possible_values
        raise ArgumentError, "Parameter #{param_name} expects #{possible_values}, got #{var} instead." 
      end
    end
  end
end