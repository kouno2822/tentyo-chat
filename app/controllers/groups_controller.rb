class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.users << current_user
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @group.update
      ridirect_to messages_path
    else
      render root_path
    end
  end

  def index
  end

  def join
    @group = Group.find(:id)
    @group.users << current_user
    @group.save
  end

  private
  def group_params
    params.require(:group).permit(:group_name)
  end
end
