class Post < ActiveRecord::Base
	has_attached_file :image, :styles => { :small => "150x150>" },
                  :url  => "/image/:id",
                  :path => ":rails_root/app/assets/images"
end

