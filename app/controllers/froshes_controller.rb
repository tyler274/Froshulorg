class FroshesController < ApplicationController
  def new
  end

  def create
  	@frosh = Frosh.new
	@frosh.name = params[:froshform][:name]
	@frosh.dinner = params[:froshform][:dinner]
	@frosh.dessert = params[:froshform][:dessert]
	@frosh.save
	redirect_to @frosh
  end

  def show
  	@frosh = Frosh.find(params[:id])
  end

  def index
  	@froshes = Frosh.all
  end
end
