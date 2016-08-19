class Comment < ApplicationRecord

  belongs_to :post
  belongs_to :user, optional: true
  mount_uploader :image, ImageUploader
  validates :body, length: { minimum: 5 }, presence: true
  has_many :votes

  def total_votes
    votes.pluck(:value).sum
  end

end
