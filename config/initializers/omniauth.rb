require 'omniauth'

OmniAuth.config.logger = Rails.logger

require 'omniauth/strategies/zendesk_oauth2'
require 'omniauth-github'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    ENV["GITHUB_CLIENT_ID"],
    ENV["GITHUB_SECRET"],
    :scope => "user:email",
    :client_options => {
      :site          => "https://#{ENV["GITHUB_API_URL"]}",
      :authorize_url => "https://#{ENV["GITHUB_WEB_URL"]}/login/oauth/authorize",
      :token_url     => "https://#{ENV["GITHUB_WEB_URL"]}/login/oauth/access_token",
    }

  provider OmniAuth::Strategies::ZendeskOAuth2,
    "deployment",
    ENV["CLIENT_SECRET"],
    scope: "users:read"
end
