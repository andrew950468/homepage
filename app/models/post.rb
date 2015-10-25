class Post < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :large => "600x600>" },
                  	:url  => ":id",
                  	:path => ":rails_root/app/assets/images/:id"
  validates :image,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }
end

