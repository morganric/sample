class PagesController < ApplicationController


def about
	@post = Post.all.where(:featured => true ).order("created_at DESC").first
end

def welcome

end

def terms

end


end
