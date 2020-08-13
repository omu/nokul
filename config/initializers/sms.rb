# frozen_string_literal: true

SMS.configure(**Nokul::Tenant.credentials.sms.to_h)
