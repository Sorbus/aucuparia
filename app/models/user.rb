class User < ActiveRecord::Base
	acts_as_authentic
	has_many :items
	has_many :comments
	validates :password, presence: true, on: :create
	validates :email, :display_name, presence: true
	validates :email, :display_name, uniqueness: true
	validates :access_tier, length: { minimum: 0, maximum: 7 }
end
