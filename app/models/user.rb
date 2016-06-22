class User < ActiveRecord::Base
	has_many :api_keys
	 validates :email, :password, presence: :true
end
