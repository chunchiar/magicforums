class Comment < ApplicationRecord

belongs_to :post
belongs_to :user, optional: true

validates :body, length: { minimum: 10 }, presence: true

end
