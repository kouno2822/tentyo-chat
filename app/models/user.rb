class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  has_many :group_users
  has_many :messages
  has_many :groups, through: :group_users

  validates :name, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,  presence: true
  validates :email,  uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :password, presence: true
  validates :password, confirmation: true, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation,presence: true

  def update_without_current_password(params, *options)
    params.delete(:current_password)
 
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
 
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
