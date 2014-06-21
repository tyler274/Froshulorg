class FroshesController < ApplicationController
  def new
  end

  def create
  	@frosh = Frosh.new
	@frosh.name = params[:froshform][:name]
	@frosh.dinner = params[:froshform][:dinner]
	@frosh.dessert = params[:froshform][:dessert]
	@frosh.save
	redirect_to froshes_path
  end

  def update
  	@frosh = Frosh.find(params[:id])
	@frosh.name = params[:frosh][:name]
	@frosh.dinner = params[:frosh][:dinner]
	@frosh.dessert = params[:frosh][:dessert]
	@frosh.save
	redirect_to froshes_path
  end

  def show
  	@frosh = Frosh.find(params[:id])
  end

  def edit
  	@frosh = Frosh.find(params[:id])
  end

  def index
  	@froshes = Frosh.all
  end
end
