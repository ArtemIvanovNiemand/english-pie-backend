class Group < ApplicationRecord
  has_secure_token :token

  has_many :users, dependent: :nullify
  has_many :lessons, dependent: :nullify
end
