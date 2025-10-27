class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :categories
  has_one_attached :poster

  validates :title, :synopsis, :release_year, :duration, :director, presence: true
end
