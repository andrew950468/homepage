class Post < ActiveRecord::Base
	has_attached_file :image, :styles => { :small => "150x150>" },
                  :url  => "/assets/posts/:id/:style/:basename.:extension",
                  :path => ":rails_root/app/assets/images"

  validates_attachment :image, :presence => true,
  :content_type => { :content_type => "image/jpg" },
  :size => { :in => 0..100.kilobytes }
end

