class Car < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :reservations, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :model, presence: true
  validates :price, presence: true
  validates :description, presence: true
  # validates :photo, presence: true
end
