module UsersHelper
	def gravatar_for(user)
	  #if user.show_gravatar
		grav_id = Digest::MD5::hexdigest(user.email.downcase)
		grav_url = "https://secure.gravatar.com/avatar/#{grav_id}"
		image_tag(grav_url, alt: user.name, class: "gravatar")	   
	  #end
	end
end
