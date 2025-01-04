class Project < ApplicationRecord
  validates :name, presence: true
  validates :public_id, uniqueness: true
  validates :user_id, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :swots, dependent: :destroy
end
