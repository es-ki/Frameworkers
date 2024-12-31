class Project < ApplicationRecord
  validates :name, presence: true
  validates :public_id, presence: true, uniqueness: true
  validates :user_id, presence: true, uniqueness: true
  validates :image, presence: true

  belongs_to :user
end
