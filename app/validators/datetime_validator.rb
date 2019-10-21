# frozen_string_literal: true

class DatetimeValidator < ActiveModel::EachValidator
  CHECKS = {
    eql:           :==,
    after:         :>,
    before:        :<,
    after_or_eql:  :>=,
    before_or_eql: :<=
  }.freeze

  class Checker
    attr_reader :attribute, :method, :comparison_value, :value, :message

    def initialize(attribute, method, comparison_value, message: nil)
      @attribute        = attribute
      @method           = method
      @comparison_value = comparison_value
      @message          = message
    end

    def check?(record)
      value_for!(record)
      return false if value.nil?

      record.send(attribute).send(CHECKS[method], value)
    end

    def check!(record)
      return if check?(record)

      value = I18n.t(:comparison_value, scope: %i[validators datetime]) if value.blank?

      record.errors.add(
        attribute,
        message || I18n.t(method, scope: %i[validators datetime], restriction: value)
      )
      false
    end

    private

    def value_for!(record)
      @value =
        case comparison_value
        when Symbol then symbol_to_value(record, comparison_value)
        when Proc   then proc_to_value(record, comparison_value)
        when String then string_to_value
        when DateTime, Date, ActiveSupport::TimeWithZone then comparison_value
        end
    end

    def symbol_to_value(record, comparison_value)
      record.send(comparison_value) if record.respond_to?(comparison_value)
    end

    def string_to_value
      Time.zone.parse(comparison_value)
    rescue ArgumentError
      nil
    end

    def proc_to_value(record, comparison_value)
      comparison_value.arity.positive? ? comparison_value.call(record) : comparison_value.call
    end
  end

  attr_reader :checkers

  def initialize(options)
    super
    @checkers = {}
    build_checkers(options)
  end

  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add attribute, :blank
    else
      checkers[attribute].each { |checker| checker.check!(record) }
    end
  end

  private

  def build_checkers(options)
    CHECKS.each do |method, _|
      next unless options.key?(method)

      @attributes.each do |attribute|
        checkers[attribute] = [] unless checkers.key?(attribute)
        checkers[attribute] << Checker.new(
          attribute, method, options[method], message: options["#{method}_message".to_sym]
        )
      end
    end
  end
end
