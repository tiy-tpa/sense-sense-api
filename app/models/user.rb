class User < ApplicationRecord
  has_many :games
  validates :access_token, presence: true, uniqueness: true
end
