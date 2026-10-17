require "rails_helper"

RSpec.describe "Sessions" do
  describe "GET /login" do
    it "offers Google sign-in" do
      get login_path
      expect(response.body).to include("Sign in with Google")
    end
  end

  describe "GET /auth/google_oauth2/callback" do
    it "creates a user on first sign-in" do
      expect { sign_in_with_google }.to change(User, :count).by(1)
    end

    it "links the Google identity to the user" do
      sign_in_with_google(uid: "abc")
      expect(User.last.identities.pluck(:provider, :uid)).to eq([ %w[google_oauth2 abc] ])
    end

    it "redirects to the home page" do
      sign_in_with_google
      expect(response).to redirect_to(root_url)
    end

    it "reuses the existing user on later sign-ins" do
      sign_in_with_google
      expect { sign_in_with_google }.not_to change(User, :count)
    end

    it "links a new identity to an existing user with the same email" do
      user = create(:user, email: "boon@example.com")
      sign_in_with_google(email: "Boon@example.com")
      expect(user.identities.count).to eq(1)
    end

    it "refreshes the name from Google" do
      user = create(:user, email: "boon@example.com", name: "Old Name")
      sign_in_with_google(name: "Boon Hunter")
      expect(user.reload.name).to eq("Boon Hunter")
    end

    it "rejects Google accounts with an unverified email" do
      expect { sign_in_with_google(verified: false) }.not_to change(User, :count)
    end

    it "sends unverified accounts back to the login page" do
      sign_in_with_google(verified: false)
      expect(response).to redirect_to(login_path)
    end

    it "returns to the page that required sign-in" do
      get "/?from=bookmark"
      sign_in_with_google
      expect(response).to redirect_to("http://www.example.com/?from=bookmark")
    end
  end

  describe "GET /auth/failure" do
    it "sends the user back to the login page with an error" do
      get "/auth/failure", params: { message: "access_denied" }
      expect(flash[:alert]).to include('Google sign-in failed')
    end
  end

  describe "DELETE /logout" do
    it "ends the session" do
      sign_in_with_google
      expect { delete logout_path }.to change(Session, :count).by(-1)
    end

    it "requires signing in again afterward" do
      sign_in_with_google
      delete logout_path
      get root_path
      expect(response).to redirect_to(login_path)
    end
  end
end
