require "rails_helper"

RSpec.describe "Signing in" do
  it "lets a writer sign in with Google and sign out" do
    mock_google_auth(name: "Boon Hunter")
    visit root_path
    click_on "Sign in with Google"
    expect(page).to have_text("Boon Hunter")

    click_on "Sign out"
    expect(page).to have_button("Sign in with Google")
  end
end
