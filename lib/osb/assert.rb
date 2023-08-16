# frozen_string_literal: true

module Osb
  class TypeError < StandardError
  end

  module Internal
    Boolean = [TrueClass, FalseClass]

    class TypedArray
      attr_accessor :type

      # @param [Class] type
      def initialize(type)
        @type = type
      end
    end

    # @type [Hash{Class => Hash{Class => Object}}]
    T = { Array => { Float => TypedArray.new(Float) } }

    # Check if supplied argument is correctly typed.
    # @param [Object] arg
    # @param [BasicObject, Array, TypedArray] possible_types
    # @param [String] param_name
    def self.assert_type!(arg, possible_types, param_name)
      if possible_types.is_a?(Array)
        valid = possible_types.any? { |type| arg.is_a?(type) }
        unless valid
          accepted_types = possible_types.map { |type| type.name }.join(" or ")
          
          raise TypeError,
                "Parameter #{param_name} expects type #{accepted_types}, " +
                  "got type #{arg.class.name} instead."
        end
      elsif possible_types.is_a?(TypedArray)
        valid = arg.all? { |value| value.is_a?(possible_types.type) }
        unless valid
          raise TypeError,
                "Parameter #{param_name} expects type Array<#{possible_types.type.name}>, " +
                  "got type #{arg.class.name} instead."
        end
      else
        type = possible_types
        unless arg.is_a?(type)
          raise TypeError,
                "Parameter #{param_name} expects type #{type.name}, " +
                  "got type #{arg.class.name} instead."
        end
      end
    end

    # Ensures the supplied argument is correct.
    # @param [Object] arg
    # @param [BasicObject, Array, Range] possible_values
    # @param [String] param_name
    def self.assert_value!(arg, possible_values, param_name)
      val =
        if arg.is_a?(String) && arg.empty?
          "an empty string"
        else
          arg
        end

      if possible_values.is_a?(Array)
        valid = possible_values.any? { |value| arg == value }
        unless valid
          accepted_values = possible_values.join(" or ")

          raise ArgumentError,
                "Parameter #{param_name} expects #{accepted_values}, " +
                  "got #{val} instead."
        end
      elsif possible_values.is_a?(Range)
        valid = arg >= possible_values.min && arg <= possible_values.max
        unless valid
          raise ArgumentError,
                "Parameter #{param_name} expects value within " +
                  "#{possible_values.min} to #{possible_values.max}, " +
                  "got #{val} instead."
        end
      else
        unless arg == possible_values
          raise ArgumentError,
                "Parameter #{param_name} expects #{possible_values}, " +
                  "got #{val} instead."
        end
      end
    end
  end
end
