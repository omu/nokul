Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.keep_original_rails_log = true

  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format id)
    {
      time: Time.now,
      params: event.payload[:params].except(*exceptions),
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object],
      host: event.payload[:host],
      remote_ip: event.payload[:remote_ip],
      user_id: event.payload[:user_id]
    }
  end
end
