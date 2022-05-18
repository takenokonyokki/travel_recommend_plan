class ContentsController < ApplicationController

  before_action :correct_user, only: [:edit, :uodate, :destroy]

  def new
    @content = Content.new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    @content = Content.new(content_params)
    @content.plan_id = params[:plan_id]
    if @content.save
      if params[:next]
        redirect_to new_plan_content_path(@content.plan_id)
      elsif params[:end]
        redirect_to plan_path(@content.plan_id)
      end
    else
      @plan = Plan.find(params[:plan_id])
      render :new
    end
  end


  def edit
    @plan = Plan.find(params[:plan_id])
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    @content.plan_id = params[:plan_id]
    @plan = Plan.find(params[:plan_id])
    if @content.update(content_params)
      redirect_to plan_path(@plan.id)
    else
      render :edit
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @plan = Plan.find(params[:plan_id])
    @content.destroy
    redirect_to plan_path(@plan.id)
  end

  def map
    #plan_idだけだと、どのcontentの住所なのかわからない為、orderも一緒に探させてあげる
    @content = Content.find_by(plan_id: params[:plan_id], order: params[:order])
  end

  private

  def content_params
    params.require(:content).permit(:image, :order, :hour, :minute, :place, :explanation, :name, :address, :telephonenumber, :access, :businesshours, :price, :stay_time, :rate, :reservation, :latitude, :longitude)
  end

  def correct_user
    @plan = Plan.find(params[:plan_id])
    # @content = Content.find(params[:id])
    unless @plan.user == current_user
      redirect_to plans_path
    end
  end
end
