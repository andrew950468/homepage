class Post < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :large => "600x600>" },
                  	:url  => ":id",
                  	:path => PAPERCLIP_FILE_PATH
  validates :image,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }
  has_many :comments 
end

