class User < ApplicationRecord
  has_many :cars, class_name: "Car", dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3 }
end
