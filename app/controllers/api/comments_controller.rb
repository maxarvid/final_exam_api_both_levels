class Api::CommentsController < ApplicationController
  def create
    if Article.exists?(comment_params[:article_id])
      Comment.create(body: comment_params[:body], article_id: comment_params[:article_id])
      render json: { message: 'The comment was created' }, status: 201
    else
      render json: { message: 'The comment cannot be empty' }, status: 422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :body)
  end
end
