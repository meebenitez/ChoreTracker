class ListsController < ApplicationController
  include ChoresHelper
  before_action :set_list, only: [:show, :edit, :update, :destroy, :join, :remove_user]
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    if can? :read, List
      @lists = current_user.lists
      @invites = current_user.invites.select {|invite| invite.status == "open" }
      #binding.pry
    else
      redirect_to root_path
    end
  end

  def new
    @list = List.new
    @list.invites.build
    @list.invites.build
    @list.invites.build
  end

  def show
    authorize! :index, List
    Chore.check_past_due(@list.chores)
    @daily_chores = create_chore_array_view("daily", @list.chores)
    @weekly_chores = create_chore_array_view("weekly", @list.chores)
    @monthly_chores = create_chore_array_view("monthly", @list.chores)
  end


  def create
    @list  = List.create(list_params)
    @list.users << current_user
    @list.admin_id = current_user.id
    #Seed starter chores
    List.create_starter_list(@list)
    # assign invites
    List.send_invites_on_list_create(@list)

    #list.chores.make_chores(@list)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  #User accepts an invite to a list
  def join
    if !@list.users.find_by(id: current_user.id)
      @list.users << current_user
      invite = current_user.invites.find_by(list_id: @list.id)
      invite.status = "closed"
      redirect_to @list
    else
      redirect_to @list
    end

  end

  #User is removed from a list by the admin
  def remove_user
    @list.users.delete(params[:user])
    redirect_to edit_list_path(@list.id)
  end

  def edit
    @daily_chores = create_chore_array_edit("daily", @list.chores)
    @weekly_chores = create_chore_array_edit("weekly", @list.chores)
    @monthly_chores = create_chore_array_edit("monthly", @list.chores)
  end

  def update
    @list.update(list_params)
    redirect_to edit_list_path(@list)
  end

  def destroy
    @list.destroy
    flash[:notice] = "deleted"
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :list_type, invites_attributes: [:email, :status])
  end

  def set_list
    @list = List.find(params[:id])
  end




end
