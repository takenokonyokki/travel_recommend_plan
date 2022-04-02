class ContentsController < ApplicationController
  def new
    @content = Content.new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    @content = Content.new(content_params)
    @content.plan_id = params[:plan_id]
    @content.save
    if params[:next]
      redirect_to new_plan_content_path(@content.plan_id)
    elsif params[:end]
      redirect_to plan_path(@content.plan_id)
    end
  end

  private

  def content_params
    params.require(:content).permit(:order_id, :day, :time, :place, :explanation, :name, :address, :telephonenumber, :access, :businesshours, :price, :stay_time, :rate, :move_time)
  end

end
