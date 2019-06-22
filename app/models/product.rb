class Product < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  belongs_to :user
  belongs_to :shop
end
