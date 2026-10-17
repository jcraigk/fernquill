class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create failure]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to login_path, alert: "Too many sign-in attempts. Try again later." }

  def new
    redirect_to root_path if authenticated?
  end

  def create
    auth = request.env["omniauth.auth"]
    unless auth.dig("extra", "raw_info", "email_verified")
      return redirect_to login_path, alert: "Your Google account's email address isn't verified."
    end

    return_to = after_authentication_url
    start_new_session_for User.from_omniauth(auth)
    redirect_to return_to
  end

  def failure
    redirect_to login_path, alert: "Google sign-in failed. Please try again."
  end

  def destroy
    terminate_session
    redirect_to login_path, status: :see_other
  end
end
