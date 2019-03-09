class User < ApplicationRecord
  extend Enumerize

  belongs_to :group, optional: true

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  enumerize :access_level, in: %i[student admin], predicates: true
end
