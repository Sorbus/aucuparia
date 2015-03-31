class UsersController < ApplicationController
	before_filter :require_no_user, only: [:new, :create]
	before_filter :require_user, only: [:show, :edit, :update]
	http_basic_authenticate_with name: "rja", password: "secret", only: [:new, :create]
	
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Account registered!"
			redirect_to @user
		else
			render 'new'
		end
	end
	
	def show
		if params[:id] == 'self'
			@user = @current_user
		else
			@user = User.find(params[:id])
		end
	end

	def edit
		@user = @current_user
	end
	
	def update
		@user = @current_user # makes our views "cleaner" and more consistent
		if @user.update_attributes(user_params)
			flash[:notice] = "Account updated!"
		redirect_to @user
		else
			render 'edit'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end