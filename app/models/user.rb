class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, 
		:recoverable, :rememberable, :trackable, :validatable,
		:omniauthable, :omniauth_providers => [:twitter]
	has_many :items
	has_many :comments
	# has_one :registration_token
	has_and_belongs_to_many :roles
	validates :password, presence: true, on: :create
	validates :email, :display_name, presence: true
	validates :email, :display_name, uniqueness: true
	validates :email, email: true
	validates :website, :url => {:allow_blank => true}
	
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			user.display_name = auth.info.name	 # assuming the user model has a name
	#		user.image = auth.info.image # assuming the user model has an image
		end
	end
	
	def role?(role)
		return !!self.roles.find_by_name(role.to_s.camelize)
	end
end
