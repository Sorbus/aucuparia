class CategoriesController < ApplicationController
	load_and_authorize_resource
	before_filter :authenticate_user!, :except => [:index, :show]

	def index
		@categories = Category.all
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
		@category = Category.find(params[:id])
		@posts = @category.items.paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def new
		@category = Category.new
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end

	def edit
		@category = Category.find(params[:id])
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
		respond_to do |format|
			format.js
			format.html
		end
	end
 
	def create
		@category = Category.new(category_params)
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
	  
		if @category.save
			flash[:notice] = "Category created."
			redirect_to @category
		else
			flash[:alert] = "Category not created!"
			render 'new'
		end
	end
	
	def update
		@category = Category.find(params[:id])
		@menu_options = Menu.all.map{|c| [ c.title, c.id ] }
 
		if @category.update(category_params)
			flash[:notice] = "Category updated."
			redirect_to @category
		else
			flash[:alert] = "Category not updated!"
			render 'edit'
		end
	end
	
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
 
		redirect_to categories_path
	end
	
	private
		def category_params
			params.require(:category).permit(:name, :summary, :menu_id)
		end
end