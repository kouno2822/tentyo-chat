class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages
  validates :group_name, presence: true, uniqueness: true

  def last_text
    last_text = messages.last
    if last_text.present?
      last_text.text
    else
      'まだメッセージがありません'
    end    
  end

  def last_text_time
    last_text = messages.last
    if last_text.present?
      last_text.created_at.to_s(:datetime_jp)
    else
      ''
    end
  end

  def self.search(search)
    return Group.all unless search
    Group.where("group_name LIKE(?)","%#{search}%")
  end
end

