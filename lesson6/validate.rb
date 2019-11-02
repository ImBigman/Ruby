module Validator

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    KIND_FORMAT = /^[Г, П]{1}+.+[й]$/.freeze
    NUMBER_FORMAT = /^\w{3}[_]*{1}\w{2}$/.freeze

    def validate_number
      raise ArgumentError if number.nil?
      raise ArgumentError if number !~ NUMBER_FORMAT
    end

    def validate_kind
      raise ArgumentError if kind.nil?
      raise ArgumentError if kind !~ KIND_FORMAT
    end

    def valid?
      validate_number
      validate_kind
      true
    rescue StandardError
      false
    end
  end
end
