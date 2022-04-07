class FavoritesController < ApplicationController
  def create
    @plan = Plan.find(params[:plan_id])
    @favorite = current_user.favorites.new(plan_id: @plan.id)
    @favorite.save
  end

  def destroy
    @plan = Plan.find(params[:plan_id])
    @favorite = current_user.favorites.find_by(plan_id: @plan.id)
    @favorite.destroy
  end
end
