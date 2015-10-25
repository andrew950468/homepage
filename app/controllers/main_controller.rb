class MainController < ApplicationController
  def index
    @posts = Post.last(10)
    @post_meta=[]
    meta = {"hadComment"=> true,"poster"=>"","buy"=> 0, "nbuy"=> 0}
    if user_signed_in?
       user = current_user
       @posts.each do |post|
         meta = {"hadComment"=> true,"poster"=>"","buy"=> 0, "nbuy"=> 0}
         meta["poster"] = User.find(post.user_id).email
         if Comment.find_by_user_id_and_post_id(user.id, post.id)
           nbuy = buy = 0
           Comment.where(post_id: post.id).find_each do |c|
             meta["buy"] += 1 if c.buy
             meta["nbuy"] += 1 unless c.buy
           end
           @post_meta.push meta
         else
           meta["hadComment"] = false;
           @post_meta.push meta
         end
       end
    else
       meta["hadComment"] = false;
       @posts.each do |post|
         meta["poster"] = User.find(post.user_id).email
         @post_meta.push meta
       end
    end
  end
  
end
