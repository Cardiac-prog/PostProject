class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 70 }
  validates :category, presence: true, length: { maximum: 15 }
end
