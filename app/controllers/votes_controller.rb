class VotesController < ApplicationController

def create
  @user = current_user
  @vote = Vote.new(vote_params)
  @vote.user_id = @user.id
  if @vote.save
    case @vote.votable_type
    when "Answer"
      redirect_to question_path(@vote.votable.question_id)
    when "Question"
      redirect_to question_path(@vote.votable.id)
    when "Comment"
      if @vote.votable.commentable_type == "Answer"
        redirect_to question_path(@vote.votable.commentable.question_id)
      elsif @vote.votable.commentable_type == "Question"
        redirect_to question_path(@vote.votable.commentable.id)
      end
    # else
    #   TODO: Add error handling
    end
end

private
  def vote_params
    params.require(:vote).permit(:value, :votable_type, :votable_id)
  end
end
