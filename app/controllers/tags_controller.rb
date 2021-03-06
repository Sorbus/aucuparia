class TagsController < ApplicationController
	def index
		@tags = (ActsAsTaggableOn::Tag.most_used).page(params[:page]).per(40)
		respond_to do |format|
			format.js
			format.html
		end
	end
	
	def show
    @tag = (ActsAsTaggableOn::Tag).find_by_id(params[:tag])
    @tag ||= params[:tag]
		@items = Item.where(:deleted => false, :published => true).tagged_with(@tag).page params[:page]
		respond_to do |format|
			format.js
			format.html
		end
	end
end
