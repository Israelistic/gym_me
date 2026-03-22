class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.event_id = params[:event_id]
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to event_url(params[:event_id])
    else
      redirect_to event_url(params[:event_id]), alert: "Comment could not be saved."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    unless @comment.user_id == current_user.id
      redirect_to event_url(params[:event_id]), alert: "You are not authorized to delete this comment."
      return
    end

    @comment.destroy
    redirect_to event_url(params[:event_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
