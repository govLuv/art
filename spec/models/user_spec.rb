require 'spec_helper'

describe User do
	before do
	   	@user = User.new(name: "Pen Name", email: "user@test.com", password: "password", password_confirmation: "password")
	end

	subject { @user }
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }

	describe "when field is too long" do
		before { @user.name = 'a' * 65 }
		it { should_not be_valid }
		before { @user.email = 'a' * 65 }
		it { should_not be_valid }
	end

	describe "when name format is invalid" do 
		names = %w[John R1ck M*.thers]
		names.each do |invalid_name|
			before { @user.name = invalid_name }
			it { should_not be_valid }
		end
	end
	
	describe "when name format is valid" do 
		names = ["John Johnson","Richard Ion Mathers IX","Pork D II"]
		names.each do |valid_name|
			before{ @user.name = valid_name }
			it { should be_valid }
			# it { should be_valid }
		end

	end

	describe "when email format is invalid" do 
		emails = %w[vasds R1ck@yy,com M*.thers@yahoo.com]
		emails.each do |invalid_email|
			before { @user.email = invalid_email }
			it { should_not be_valid }
		end

	end

	describe "when email format is valid" do 
		emails = %w[vasds@aol.com R1ck@yy.com M-thers@yahoo.com]
		emails.each do |valid_email|
			before { @user.email = valid_email }
			it { should be_valid }
		end

	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
	  		user_with_same_email.save
		end
		it { should_not be_valid }
	end
	
	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }
		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }	
		end

	    describe "with invalid password" do
		    let(:user_for_invalid_password) { found_user.authenticate("invalid") }
		    it { should_not eq user_for_invalid_password }
		    specify { expect(user_for_invalid_password).to be_false }
		end
	end
end
