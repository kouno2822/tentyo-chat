class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :group_users
  has_many :messages
  has_many :groups, through: :group_users
  validates :name, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,  presence: true
  validates :email,  uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
end
