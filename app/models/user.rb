class User < ActiveRecord::Base
	before_save { 
		# stadardize storage in database
		self.email = email.downcase 
		self.name  = name.downcase
	}
	

	# Name is two or three words without numbers or 
	# symbols (except hyphen)
	VALID_NAME_REGEX = /\A[a-z-]+[ ][a-z-]+([ ][a-z-]+)?([ ][IVXL]+)?\z/i
	validates :name, length: { maximum: 64 }, format: { with: VALID_NAME_REGEX }, uniqueness: { case_sensitive: false }

	# Email validation
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, length: { maximum: 64 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	# Password validation
	validates :password, length: { maximum: 64, minimum: 6 }
	has_secure_password
end
