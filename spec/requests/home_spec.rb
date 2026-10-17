require "rails_helper"

RSpec.describe "Home" do
  it "redirects visitors to the login page" do
    get root_path
    expect(response).to redirect_to(login_path)
  end

  it "greets a signed-in writer by name" do
    sign_in_with_google(name: "Boon Hunter")
    get root_path
    expect(response.body).to include("Boon Hunter")
  end
end
