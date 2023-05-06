class PagesController < ApplicationController

  before_action :search

  def home
    @rooms = Room.where(active: true).limit(3)
  end

  def search
    @search = Room.ransack(params[:q])
    @rooms = @search.result
  end

end
