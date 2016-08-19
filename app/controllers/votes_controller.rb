class VotesController < ApplicationController

  respond_to :js
  before_action :authenticate!
  before_action :find_or_create_vote

  def upvote
    update_vote(1)
    flash[:success] = "You have upvoted."
  end

  def downvote
    update_vote(-1)
    flash[:danger] = "You have downvoted."
  end


  private

    def find_or_create_vote
      @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
    end

    def update_vote(value)
      if @vote && @vote.value != value
        @vote.update(value: value)
        VoteBroadcastJob.perform_later(@vote.comment)
      end
    end
end
