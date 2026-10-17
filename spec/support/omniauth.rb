OmniAuth.config.test_mode = true

module OmniAuthHelpers
  def mock_google_auth(uid: "google-uid-123", email: "boon@example.com", name: "Boon Hunter", verified: true)
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: "google_oauth2",
      uid:,
      info: { email:, name:, image: "https://example.com/avatar.png" },
      extra: { raw_info: { email_verified: verified } }
    )
  end

  def sign_in_with_google(**)
    mock_google_auth(**)
    get "/auth/google_oauth2/callback"
  end
end

RSpec.configure do |config|
  config.include OmniAuthHelpers, type: :request
  config.include OmniAuthHelpers, type: :feature
  config.after { OmniAuth.config.mock_auth[:google_oauth2] = nil }
end
