class UserController < ApplicationController
 before_action :authenticate_user!
  def index
    user = current_user
    @posts = user.posts 
    @post_meta=[]
    meta = {"buy"=> 0, "nbuy"=> 0}
    @posts.each do |post|
      if Comment.find_by_post_id(post.id)
        Comment.where(post_id: post.id).find_each do |c|
          meta["buy"] += 1 if c.buy
          meta["nbuy"] += 1 unless c.buy
        end
      end
      @post_meta.push meta
    end
  end
end
