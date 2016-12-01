class VisitorsController < ApplicationController

	def index
		@post = Post.all.where(featured: true).order("created_at DESC").first
	end
end
