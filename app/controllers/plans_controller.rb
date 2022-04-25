class PlansController < ApplicationController

  before_action :correct_user, only: [:edit, :update, :destroy]

  before_action :move_to_index, except: [:index]

  before_action :set_user, only: [:favorites]

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    @plan.travel = Plan.travels[plan_params[:travel]]
    if @plan.save
      redirect_to new_plan_content_path(@plan.id)
    else
      render :new
    end
  end

  def index
    @plans = Plan.page(params[:page])
  end

  def show
    @plan = Plan.find(params[:id])
    @contents = Content.where(plan_id: @plan.id)
    @comments = Comment.where(plan_id: @plan.id)
    @comment = Comment.new
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to plan_path(@plan.id)
    else
      render :edit
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to plans_path
  end

  def mypage
    @plans = Plan.where(user_id: current_user.id).page(params[:page])
    @user = current_user
  end

  def favorites
    @favorites = Favorite.where(user_id: @user.id).pluck(:plan_id)
    @favorite_plans = Kaminari.paginate_array(Plan.find(@favorites)).page(params[:page])
    @user = current_user
  end

  def search
    @plans = Plan.search(params[:keyword]).page(params[:page])
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :image, :travel)
  end

  def correct_user
    @plan = Plan.find(params[:id])
    unless @plan.user == current_user
      redirect_to plans_path
    end
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
