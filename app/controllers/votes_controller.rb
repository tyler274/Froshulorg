class VotesController < ApplicationController
  def index
  	@frosh = Frosh.find(params[:frosh_id])
  	@votes = @frosh.votes
  end

  def new
  	@frosh = Frosh.find(params[:frosh_id])
  end

  def create
  	@frosh = Frosh.find(params[:frosh_id])
  	@vote = @frosh.votes.create
	@vote.value = params[:voteobj][:value];
	@vote.save
	redirect_to frosh_votes_path(@frosh)
  end

  def destory
  	
  end
end
