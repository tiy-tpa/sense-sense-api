class User < ApplicationRecord
  has_many :items
  validates :access_token, presence: true, uniqueness: true
end
