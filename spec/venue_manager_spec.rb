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
      User.create(username: 'testaccount', password: 'testpassword')
      visit '/'
      click_on('Log In')
      fill_in(:username, :with => 'testaccount')
      fill_in(:password, :with => 'testpassword')
      click_on('submit')
      expect(page.current_path).to eq('/home')
      expect(page.body).to include('Venue')
    end

    it "lets a user create an account" do
      visit '/'
      click_on('Sign Up')
      fill_in(:first_name, :with => 'test')
      fill_in(:last_name, :with => 'account')
      fill_in(:username, :with => 'testaccount')
      fill_in(:password, :with => 'testpassword')
      click_on('Sign Up')
      visit '/account'
      expect(page.body).to include('test account')
      expect(page.body).to include('testaccount')
    end
  end

  context 'create and read' do
    it 'lets you create a venue and redirects you to that venue\'s show page' do
      User.create(username: 'testaccount', password: 'testpassword')
      visit '/'
      click_on('Log In')
      fill_in(:username, :with => 'testaccount')
      fill_in(:password, :with => 'testpassword')
      click_on('submit')
      visit '/venues/new'
      fill_in(:name, :with => 'test venue')
      select('Proscenium', from: 'configuration' )
      fill_in(:seats, :with => '75')
      click_on('Create')
      expect(page.body).to include('test venue')
      expect(page.current_path).to include("/venues/#{Venue.last.id}")
    end
  end

  context 'update' do
    it 'lets you edit a venue' do
      user = User.create(username: 'testaccount', password: 'testpassword')
      venue = Venue.create(name: 'Original', stage_type: 'Studio', seats: '300', user_id: 1)

      visit '/login'
      fill_in(:username, :with => 'testaccount')
      fill_in(:password, :with => 'testpassword')
      click_on('submit')

      visit "/venues/#{venue.id}/edit"
      fill_in(:name, :with => 'Updated')
      select('Studio', from: 'configuration')
      fill_in(:seats, :with => '100')
      click_on('Update')
      
      expect(Venue.find_by(name: 'Original')).to eq(nil)
      expect(page.status_code).to eq(200)
    end
  end

  context 'delete' do
    it 'lets you delete a venue' do
      user = User.create(username: 'testaccount', password: 'testpassword')
      venue = Venue.create(name: 'Original', stage_type: 'Studio', seats: '300', user_id: 1)

      visit '/login'
      fill_in(:username, :with => 'testaccount')
      fill_in(:password, :with => 'testpassword')
      click_on('submit')

      visit "/venues/#{venue.id}"
      click_on('Delete')

      expect(Venue.find_by(name: 'Original')).to eq(nil)
      expect(page.status_code).to eq(200)
    end
  end
end
