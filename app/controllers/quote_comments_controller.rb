class QuoteCommentsController < ApplicationController

  def create
    @quote = params[:quote_comment][:commentable_id]
    @commment = Comment.build_from(@quote, @current_user, params[:quote_comment][:body])
    # @comment.save
    redirect_to @quote

  end
end
