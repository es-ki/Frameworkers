class Project < ApplicationRecord
  validates :name, presence: true
  validates :public_id, presence: true, uniqueness: true
  validates :user_private_id, presence: true, uniqueness: true
  validates :image, presence: true

  belongs_to :user, foreign_key: "user_private_id", primary_key: "private_id"
end
