class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.plan_id = params[:plan_id]
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @plan = Plan.find(params[:plan_id])
    @comment.destroy
    redirect_to plan_path(@plan.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
