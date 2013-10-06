module SessionsHelper
	def sign_in(user)
		session[:remember_token] = user.id
		# TODO: Add sign in across browser sessions
	end

	def sign_out
		session[:remember_token] = nil
	end

	def current_user
		User.find_by_id(session[:remember_token])
	end

	def signed_in?
		!current_user.nil?
	end
end
