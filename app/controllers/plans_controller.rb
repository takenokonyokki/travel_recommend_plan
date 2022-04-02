class PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
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
    @contents = Content.all
  end

  def edit
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :image).merge(travel: params[:plan][:travel].to_i)
  end

end
