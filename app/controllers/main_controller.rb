class MainController < ApplicationController
  def index
    @posts = Post.last(10)
    @post_meta=[]
    plain_meta = {"hadComment"=> false,"buy"=> 0, "nbuy"=> 0}
    meta = {"hadComment"=> true,"buy"=> 0, "nbuy"=> 0}
    if user_signed_in?
       user = current_user
       @posts.each do |post|
         if Comment.find_by_user_id_and_post_id(user.id, post.id)
           nbuy = buy = 0
           Comment.where(post_id: post.id).find_each do |c|
             buy += 1 if c.buy
             nbuy += 1 unless c.buy
           end
           meta["buy"] = buy
           meta["nbuy"] = nbuy
           @post_meta.push meta
         else
           @post_meta.push plain_meta
         end
       end
    else
       @posts.each do |post|
         @post_meta.push plain_meta
       end
    end
  end
  
end
