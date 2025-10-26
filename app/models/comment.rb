class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :movie

  validates :name, presence: true, unless: -> {user.present?}
  validates :content, presence: true

  before_validation :set_default_name

  private

  def set_default_name
    if user.present?
      self.name = user.name.presence || user.username
    else
      self.name = "Anônimo" if name.blank?
    end
  end
end
