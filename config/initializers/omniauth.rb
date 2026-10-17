Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV.fetch("OAUTH_GOOGLE_KEY", nil),
           ENV.fetch("OAUTH_GOOGLE_SECRET", nil),
           scope: "email,profile",
           prompt: "select_account"
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = ->(env) { OmniAuth::FailureEndpoint.new(env).redirect_to_failure }
