class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages
  validates :group_name, presence: true, uniqueness: true

  def last_text
    last_text = messages.first
    if last_text.present?
      last_text.text
    else
      'まだメッセージがありません'
    end    
  end

  def last_text_time
    last_text = messages.first
    if last_text.present?
      last_text.created_at.to_s(:datetime_jp)
    else
      ''
    end
  end

  # def self.search(search)
  #   return Group.all unless search
  #   Group.where("group_name LIKE(?)","%#{search}%")
  # end

  def self.sort_group
    includes(:messages).joins(:messages).order("messages.created_at DESC")

    # includes(:messages).joins(:messages).where().order("created_at DESC")
  end

  def self.double_search(keyword,filter,user)
    if keyword.present? && filter == '1'
      Group.where("group_name LIKE(?)","%#{keyword}%").where(id: user.groups)
    elsif keyword.present?
      Group.where("group_name LIKE(?)","%#{keyword}%")
    elsif filter == '1'
      user.groups
    else
      def self.text_groups
        Group.sort_group
      end
      def self.no_text_groups
        Group.left_joins(:messages).where(messages: {text: nil}).order('created_at DESC')
      end
    end
  end

end

