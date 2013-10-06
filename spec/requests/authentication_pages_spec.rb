require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "sign in" do
	before { visit root_path }

	describe "with valid info" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			fill_in "session_name", with: user.email.upcase
			fill_in "session_password", with: user.password
			click_button "Sign in" 
		end

		it { should have_title(user.name) }
    end

	describe "with invalid info" do
		before { click_button "Sign in" }
		it { should have_selector("div.error") }
    end
  end
end
