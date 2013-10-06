class SessionsController < ApplicationController

	def create
		user = User.find_by(name: params[:session][:name].downcase)
		if user.nil?
			user = User.find_by(email: params[:session][:name].downcase)
		end

		if user && user.authenticate(params[:session][:password])
			sign_in(user)
			#	session[:remember_token] = user.id
			if :from_home?
				redirect_to user
			else 
				redirect_to :back
			end
		else
			flash[:error] = "Not a valid email/password synthesis."
			redirect_to :back	
		end

			
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
