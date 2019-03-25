# frozen_string_literal: true

class AddCountryRegulationsForSmsToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :sms_delivery_report, :boolean, default: false
    add_column :countries, :sms_alpha_sender_id, :boolean, default: false
    add_column :countries, :sms_unicode, :boolean, default: false
    add_column :countries, :sms_concatenation, :boolean, default: false

    execute "UPDATE countries SET sms_delivery_report = false WHERE sms_delivery_report IS NULL"
    execute "UPDATE countries SET sms_alpha_sender_id = false WHERE sms_alpha_sender_id IS NULL"
    execute "UPDATE countries SET sms_unicode = false WHERE sms_unicode IS NULL"
    execute "UPDATE countries SET sms_concatenation = false WHERE sms_concatenation IS NULL"

    add_null_constraint :countries, :sms_delivery_report
    add_null_constraint :countries, :sms_alpha_sender_id
    add_null_constraint :countries, :sms_unicode
    add_null_constraint :countries, :sms_concatenation
  end
end
