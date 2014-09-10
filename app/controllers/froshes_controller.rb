class FroshesController < ApplicationController
  def new
  end

  def create
  	@frosh = Frosh.new
    #TODO use mass assignment if desired
	@frosh.name = params[:froshform][:name]
    if params[:froshform][:last_name] == ""
      @frosh.last_name = params[:froshform][:name].split(" ")[-1]
    else
      @frosh.last_name = params[:froshform][:last_name]
    end
	@frosh.dinner = params[:froshform][:dinner]
	@frosh.dessert = params[:froshform][:dessert]
	@frosh.image_url = params[:froshform][:image_url]
    if @frosh.image_url == ""
        @frosh.image_url = "noimg.png"
    end
	@frosh.anagram = params[:froshform][:anagram]
	@frosh.interest_url = params[:froshform][:interest_url]
    @frosh.male = params[:froshform][:male]
	@frosh.save
	redirect_to froshes_path
  end

  def update
  	@frosh = Frosh.find(params[:id])
	@frosh.name = params[:frosh][:name]
	@frosh.last_name = params[:frosh][:last_name]
	@frosh.dinner = params[:frosh][:dinner]
	@frosh.dessert = params[:frosh][:dessert]
	@frosh.image_url = params[:frosh][:image_url]
	@frosh.anagram = params[:frosh][:anagram]
	@frosh.interest_url = params[:frosh][:interest_url]
    @frosh.male = params[:frosh][:male]
	@frosh.save
	redirect_to froshes_path
  end

  def show
  	@frosh = Frosh.find(params[:id])
  end

  def edit
  	@frosh = Frosh.find(params[:id])
  end
  
  def comments
  	@frosh = Frosh.find(params[:frosh_id])
  end

  def save_comments
  	@frosh = Frosh.find(params[:frosh_id])
    @frosh.comments = params[:frosh][:comments]
    @frosh.nickname = params[:frosh][:nickname]
	@frosh.save
	redirect_to froshes_path
  end

  def destroy
    Frosh.find(params[:id]).destroy
    redirect_to froshes_path
  end

  def index
  	@froshes = Frosh.all
  end
end
