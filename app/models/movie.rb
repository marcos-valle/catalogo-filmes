class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :synopsis, :release_year, :duration, :director, presence: true
end
