class Frosh < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  resort!
  # attr_accessible :title, :body
  has_many :votes

  has_many :won_compares, class_name: :Comparison, foreign_key: :winner_id, dependent: :destroy
  has_many :lost_compares, class_name: :Comparison, foreign_key: :loser_id, dependent: :destroy

  def prelim_score
    @prelim_score ||= votes.map(&:value).inject{ |sum, x| sum + x } || 0
  end

  def color
    @color ||= ["green", "blue", "red"][list]
  end

  def percent_voted
    #change this depending on max number of votes
    #TODO using a helper here is bad or whatever blah blah blah
    @percent_voted ||= number_to_percentage(votes.length, precision: 1)
  end
end
