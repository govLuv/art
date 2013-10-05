require 'spec_helper'

describe "User Pages" do
  subject { page }
  describe "register page" do
	before { visit join_path }
	it { should have_content("Pen Name") }
  end

  describe "artist's page" do
	let(:user) { FactoryGirl.create(:user) }
	before { visit user_path(user) }
	it { should have_content(user.name) }
  end

  describe "register" do
	before { visit join_path }
	let(:submit) { "Register" }

	describe "with valid info" do
	  before do
		fill_in "Name", with: "Exam Usr"
		fill_in "Email", with: "e@gmail.com"
		fill_in "Password", with: "passwod"
	    fill_in "Again", with: "passwod"
	  end
	  it "should create user" do
		expect { click_button submit }.to change(User, :count).by(1)
	  end
	end

  	describe "with invalid info" do
	  before do
		fill_in "Name", with: "Exam Usr"
		fill_in "Email", with: "egmail.com"
		fill_in "Password", with: "passwod"
	    fill_in "Again", with: "passwo"
	  end
		it "shouldn't create user" do
			expect { click_button submit }.not_to change(User, :count)
		end
	end		
  end
end
