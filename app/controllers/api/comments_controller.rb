class Api::CommentsController < ApplicationController

  def create
    render json: { message: 'Hello world!' }, status: 201
  end
end
