class MessagesController < ApplicationController
  before_action :set_group

  def index
    @groups = Group.all
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = @group.messages.includes(:user)
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group)
    else
      redirect_to group_messages_path(group), notice: 'メッセージ送信に失敗しました'
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end

end
