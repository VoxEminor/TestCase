class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :files

  validates :title, presence: true, length: {minimum: 2}
  validates :description, presence: true, length: {minimum: 2}
end
