class PlansController < ApplicationController

  before_action :correct_user, only: [:edit, :update, :destroy]

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
    @plans = Plan.all
  end

  def show
    @plan = Plan.find(params[:id])
    @contents = Content.where(plan_id: @plan.id)
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update(plan_params)
    redirect_to plan_path(plan.id)
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to plans_path
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

end
