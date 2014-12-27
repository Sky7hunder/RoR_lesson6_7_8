class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments, dependent: :destroy
  validates :name, presence: true

  acts_as_voter
end
