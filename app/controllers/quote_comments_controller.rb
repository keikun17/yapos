class QuoteCommentsController < ApplicationController

  def create
    @quote = Quote.find params[:quote_comment][:commentable_id]
    @comment = Comment.build_from(@quote, current_user.id, params[:quote_comment][:body])
    @comment.save

    redirect_to @quote, success: 'Comment added succesfully'
  end
end
