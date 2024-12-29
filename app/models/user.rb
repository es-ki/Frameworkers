class User < ApplicationRecord
  validates :private_id, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :projects, foreign_key: 'user_private_id', primary_key: 'private_id'
end
