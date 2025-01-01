class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :projects, dependent: :destroy

  after_create :create_default_project

  private

  def create_default_project
    projects.create!(name: "新規プロジェクト", image: "default.jpg")
  rescue ActiveRecord::RecordNotSaved => e
    ErrorUtility.logger(e, "ユーザー保存")
    raise
  rescue StandardError => e
    ErrorUtility.logger e
    raise
  end

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      user = find_or_initialize_by(uid: user_params[:uid])
      user.assign_attributes(user_params)
      user.save!
      user
    rescue ActiveRecord::RecordNotSaved => e
      ErrorUtility.logger(e, "ユーザー保存")
      raise
    rescue StandardError => e
      ErrorUtility.logger e
      raise
    end

    private

    def user_params_from_auth_hash(auth_hash)
      { uid: auth_hash.uid, email: auth_hash.info.email }
    end
  end
end
