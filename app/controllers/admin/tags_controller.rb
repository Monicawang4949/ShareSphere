class Admin::TagsController < ApplicationController
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to request.referer
  end

  def index
    @tags = Tag.all
  end
end
