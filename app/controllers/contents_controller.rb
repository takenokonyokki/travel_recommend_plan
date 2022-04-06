class ContentsController < ApplicationController

  before_action :correct_user, only: [:edit, :uodate, :destroy]

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

  def edit
    @plan = Plan.find(params[:plan_id])
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    @plan = Plan.find(params[:plan_id])
    @content.update(content_params)
    redirect_to plan_path(@plan.id)
  end

  def destroy
    @content = Content.find(params[:id])
    @plan = Plan.find(params[:plan_id])
    @content.destroy
    redirect_to plan_path(@plan.id)
  end

  private

  def content_params
    params.require(:content).permit(:image, :order, :hour, :minute, :place, :explanation, :name, :address, :telephonenumber, :access, :businesshours, :price, :stay_time, :rate)
  end

  def correct_user
    @plan = Plan.find(params[:plan_id])
    # @content = Content.find(params[:id])
    unless @plan.user == current_user
      redirect_to plans_path
    end
  end
end
