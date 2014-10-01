class Frosh < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  resort!
  # attr_accessible :title, :body
  has_many :votes

  has_many :won_compares, class_name: :Comparison, foreign_key: :winner_id, dependent: :destroy
  has_many :lost_compares, class_name: :Comparison, foreign_key: :loser_id, dependent: :destroy

  def prelim_score
    if(votes.length == 0)
      return -1
    else
      #average = ( votes.map(&:value).inject{ |sum, x| sum + x } || 0 ).to_f / (votes.length + 1)
      score = 0.5 * mean * 0.2
      if(mean > 3.5)
        score += 1.3 * votes.length.to_f / 9
        # TODO
        score -= 0.25 * stdev / 3
      elsif(mean < 2)
        score -= 1.3 * votes.length.to_f / 9
        # TODO
        score += 0.25 * stdev / 3
      end
    end
    puts score
    return score
  end

  def color
    @color ||= ["green", "blue", "red"][list] if list
  end

  def percent_voted
    #change this depending on max number of votes
    #TODO using a helper here is bad or whatever blah blah blah
    #@percent_voted ||= number_to_percentage(votes.length * 3.224131, precision: 1)
    @percent_voted ||= votes.length
  end

  def mean
    @mean ||= votes.map(&:value).inject(0) { |sum, x| sum += x } / votes.size.to_f
  end

  def stdev
    if(votes.length > 1)
      @stdev = Math.sqrt(votes.map(&:value).inject(0) { |variance, x| variance += (x - mean) ** 2 } / (votes.length - 1))
    else
      0
    end
  end
end
