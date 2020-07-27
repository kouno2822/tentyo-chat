class MessagesController < ApplicationController
  before_action :set_group
  before_action :transition_limit, only: [:index]

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @modal = Group.new
    Group.double_search(params[:keyword],params[:filter],current_user)
    @text_groups = Group.text_groups(params[:keyword],params[:filter],current_user)
    @no_text_groups = Group.no_text_groups(params[:keyword],params[:filter],current_user)
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      @messages = @group.messages.includes(:user)
      render :index, notice: 'メッセージ送信に失敗しました'
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end

  def transition_limit
    clicked_group_id = Group.find(params[:group_id]).id
    unless current_user.group_users.find_by(group_id: clicked_group_id)
      redirect_to root_path, notice: '「参加する」ボタンを押し、グループに参加してください'
    end
  end

end
