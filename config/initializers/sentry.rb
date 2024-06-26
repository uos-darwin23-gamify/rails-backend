Sentry.init do |config|
    config.dsn = ENV["SENTRY_DSN"] unless Rails.env.development? || Rails.env.test?
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0
    # or
    # config.traces_sampler = lambda do |context|
    #   true
    # end
end

Sentry.capture_message("New Start-Up On Production Server (rails-backend/info)")