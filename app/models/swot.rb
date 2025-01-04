class Swot < ApplicationRecord
  validates :public_id, uniqueness: true

  belongs_to :project
end
