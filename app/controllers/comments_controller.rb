class CommentsController < ApplicationController

  def create
    @user = current_user
    @comment = current_user.comments.new(comment_params)

    if @comment.save && @comment.commentable_type == "Answer"
        redirect_to question_path(@comment.commentable.question_id)
    elsif @comment.save && @comment.commentable_type == "Question"
        redirect_to question_path(@comment.commentable_id)
    else
      #TODO: Add error handling, change path
      redirect_to root_path
    end
  end

private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end

