class Api::CommentsController < ApplicationController

  def create
    Comment.create(body: comment_params)
    render json: { message: 'The comment was created' }, status: 201
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
