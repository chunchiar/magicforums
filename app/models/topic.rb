class Topic < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :history
  has_many :posts
  validates :title, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 10 }, presence: true

  before_save :update_slug

  private

  def update_slug
    self.slug = title if self.slug != title
  end


end
