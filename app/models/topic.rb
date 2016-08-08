class Topic < ApplicationRecord

has_many :posts
belongs_to :topic, optional: true

end
