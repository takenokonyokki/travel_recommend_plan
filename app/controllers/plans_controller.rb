class PlansController < ApplicationController
  def new
    @plan = Plan.new
    @content = Content.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.save
    @content = Content.new(content_params)
    @content.save
    redirect_to plans_path
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :image_id).merge(travel: params[:plan][:travel].to_i)
  end

  def content_params
    params.require(:content).permit(:order_id, :day, :time, :place, :image_id, :explanation, :name, :address, :telephonenumber, :access, :businesshours, :price, :stay_time, :rate, :move_time)
  end

end
