=begin
require 'spec_helper'

describe "StaticPages" do
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get static_pages_index_path
      response.status.should be(200)
    end
  end
end
=end

require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do

    it "should have the content 'Home'" do
      visit root_path
      expect(page).to have_content('Home')
    end


    it "should have the base title" do
      visit root_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

    it "should have a custom page title" do
      visit root_path
      expect(page).to have_title('| Home')
    end

  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the base title" do
      visit help_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

    it "should have a custom page title" do
  	  visit help_path
  	  expect(page).to have_title("| Help")
  	end

  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end

    it "should have the base title" do
      visit about_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      visit about_path
      expect(page).to have_title("| About")
    end

  end

  describe "Contact" do

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the base title" do
      visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      visit contact_path
      expect(page).to have_title("| Contact")
    end

  end

end