require_relative "spec_helper"

def app
  ApplicationController
end

describe ApplicationController do
  context 'Log in or sign up' do
    it "welcomes the user" do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome")
    end

    it "prompts the user to log in or signup" do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Log In")
      expect(last_response.body).to include("Sign Up")
    end

    it "lets a user log in with established credentials" do
      get '/'
      click_link('Log In')
      fill_in('username'), :with => 'testaccount'
      fill_in('password'), :with => 'testpassword'
      click_button('submit')
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Venues")
  end
end
