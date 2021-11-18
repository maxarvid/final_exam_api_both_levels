class Api::CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  
  def create
    comment = Comment.new(comment_params)
    comment.save

    if comment.persisted?
      render json: { message: 'The comment was created' }, status: 201
    elsif !comment[:body]
      render json: { message: 'The comment cannot be empty' }, status: 422
    else
      render json: { message: 'Comments must be made on an article' }, status: 422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :body)
  end
end
