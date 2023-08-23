# frozen_string_literal: true

module Osb
  # @private
  class TypeError < StandardError
  end

  # @private
  class InvalidValueError < StandardError
  end

  # @private
  module Internal
    # @private
    Boolean = [TrueClass, FalseClass]

    # @private
    class TypedArray
      # @param [Class] type
      def initialize(type)
        @type = type
      end

      def name
        "Array<#{@type.name}>"
      end

      def valid?(object)
        object.is_a?(Array) && object.all? { |value| value.is_a?(@type) }
      end
    end

    # @private
    T = {
      Array => {
        Numeric => TypedArray.new(Numeric),
        Integer => TypedArray.new(Integer)
      }
    }

    # Check if supplied argument is correctly typed.
    # @param [Object] arg
    # @param [BasicObject, Array, TypedArray] possible_types
    # @param [String] param_name
    # @return [void]
    # @private
    def self.assert_type!(arg, possible_types, param_name)
      if possible_types.is_a?(Array)
        valid =
          possible_types.any? do |type|
            type.is_a?(TypedArray) ? type.valid?(arg) : arg.is_a?(type)
          end
        unless valid
          accepted_types = possible_types.map { |type| type.name }.join(" or ")

          raise TypeError,
                "Parameter #{param_name} expects type #{accepted_types}, " +
                  "got type #{arg.class.name} instead."
        end
      elsif possible_types.is_a?(TypedArray)
        valid = possible_types.valid?(arg)
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
    # @return [void]
    # @private
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

          raise InvalidValueError,
                "Parameter #{param_name} expects #{accepted_values}, " +
                  "got #{val} instead."
        end
      elsif possible_values.is_a?(Range)
        valid = arg >= possible_values.min && arg <= possible_values.max
        unless valid
          raise InvalidValueError,
                "Parameter #{param_name} expects value within " +
                  "#{possible_values.min} to #{possible_values.max}, " +
                  "got #{val} instead."
        end
      else
        unless arg == possible_values
          raise InvalidValueError,
                "Parameter #{param_name} expects #{possible_values}, " +
                  "got #{val} instead."
        end
      end
    end

    # Ensure the file name extenstion is correct.
    # @param [String] file_name
    # @param [String, Array<String>] exts
    # @private
    def self.assert_file_name_ext!(file_name, exts)
      if exts.is_a?(Array)
        exts_ = exts.join("|")
        exts__ = exts.join(" or ")
        unless /[\w\s\d]+\.(#{exts_})/.match(file_name)
          raise InvalidValueError, "File name must end with #{exts__}"
        end
      else
        unless /[\w\s\d]+\.#{exts}/.match(file_name)
          raise InvalidValueError, "File name must end with #{exts}"
        end
      end
    end
  end
end
