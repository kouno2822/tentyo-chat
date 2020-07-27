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
  
  
  def self.sort_text_group
    includes(:messages).joins(:messages).order("messages.created_at DESC")
  end

  def self.sort_no_text_group
    left_joins(:messages).where(messages: {text: nil}).order('created_at DESC')
  end

  def self.double_search(keyword,filter,user)
    if keyword.present? && filter == '1'
      def self.text_groups(keyword,filter,user)
        Group.where("group_name LIKE(?)","%#{keyword}%").where(id: user.groups).sort_text_group
      end
      def self.no_text_groups(keyword,filter,user)
        Group.where("group_name LIKE(?)","%#{keyword}%").where(id: user.groups).sort_no_text_group
      end
    elsif keyword.present?
      def self.text_groups(keyword,filter,user)
        Group.where("group_name LIKE(?)","%#{keyword}%").sort_text_group
      end
      def self.no_text_groups(keyword,filter,user)
        Group.where("group_name LIKE(?)","%#{keyword}%").sort_no_text_group
      end
    elsif filter == '1'
      def self.text_groups(keyword,filter,user)
        user.groups.sort_text_group   
      end
      def self.no_text_groups(keyword,filter,user)
        user.groups.sort_no_text_group
      end
    else
      def self.text_groups(keyword,filter,user)
        Group.sort_text_group
      end
      def self.no_text_groups(keyword,filter,user)
        Group.sort_no_text_group
      end
    end
  end

end

