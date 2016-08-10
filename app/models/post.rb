class Post < ApplicationRecord

has_many :comments
belongs_to :topic
belongs_to :user, optional: true
mount_uploader :image, ImageUploader
validates :title, length: { minimum: 5 }, presence: true
validates :body, length: { minimum: 10 }, presence: true


end
