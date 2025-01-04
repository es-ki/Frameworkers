class Swot < ApplicationRecord
  validates :public_id, uniqueness: true
  validate :at_least_one_field_present

  belongs_to :project

  private

  def at_least_one_field_present
    if [ strength, weakness, opportunity, threat, analysis ].all? { |field| field.blank? }
      errors.add(:base, "1つ以上の項目の入力が必要です。")
    end
  end
end
