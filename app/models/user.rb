class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :projects, dependent: :destroy

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(email: user_params[:email]) do |user|
        user.update(user_params)
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      { email: auth_hash.info.email }
    end
  end
end
