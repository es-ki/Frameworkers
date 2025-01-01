class Project < ApplicationRecord
  validates :name, presence: true
  validates :public_id, uniqueness: true
  validates :user_id, presence: true
  validates :image, presence: true

  belongs_to :user

  before_create :generate_public_id

  private

  def generate_public_id
    self.public_id = SecureRandom.uuid
  end
end
