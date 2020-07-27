class GroupsController < ApplicationController
  before_action :set_group , only:[:destroy, :join]
  
  def create
    @group = Group.new(group_params)
    @group.users << current_user
    if @group.save
      redirect_to  group_messages_path(@group), notice: 'グループを作成しました'
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
  end
  
  def update
    if @group.update
      redirect_to messages_path
    else
      render root_path
    end
  end

  def index
    @modal = Group.new
    # @groups = Group.all.order("created_at DESC")
    # @groups = Group.sort_group
    # binding.pry
    # @search_groups = checkbox
    # @search_groups = Group.search(params[:keyword])

    @groups = Group.double_search(params[:keyword],params[:filter],current_user)
    @text_groups = Group.text_groups
    @no_text_groups = Group.no_text_groups
  end

  def destroy
    @group.users.delete(current_user)
    redirect_to root_path, notice: 'グループから退会しました'
  end

  def join
    @group.users << current_user
    @group.save
    redirect_to group_messages_path(@group), notice: 'グループに参加しました'
  end

  private
  def group_params
    params.require(:group).permit(:group_name)
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
