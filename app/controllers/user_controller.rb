class UserController < ApplicationController
 before_action :authenticate_user!
  def index
    user = current_user
    @posts = user.posts 
  end
end
