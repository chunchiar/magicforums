class Post < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :comments
  belongs_to :topic
  belongs_to :user, optional: true
  mount_uploader :image, ImageUploader
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true

  before_save :update_slug

  private

  def update_slug
    self.slug = title if self.slug != title
  end

end
