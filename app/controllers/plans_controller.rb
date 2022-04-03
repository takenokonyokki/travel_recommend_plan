class PlansController < ApplicationController
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
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :image, :travel)
  end

end
