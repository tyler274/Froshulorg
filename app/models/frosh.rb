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
      score = (mean * votes.length.to_f + art_votes * 2.5) / (votes.length.to_f + art_votes)
      
      score += -0.2 * stdev_adj
      
      #if(mean > 3.0)
      #  exp_factor = 1.0 / (1.0 + Math.exp(-3.0 * (mean - 4.0)))
      #  score += exp_factor * 1.3 * votes.length.to_f / 9
        # TODO
      #  score -= exp_factor * 0.25 * stdev / 3
      #else
      #  exp_factor = 1.0 - 1.0 / (1.0 + Math.exp(-3.0 * (mean - 2.0)))
      #  score -= exp_factor * 1.3 * votes.length.to_f / 9
      #  # TODO
      #  score += exp_factor * 0.25 * stdev / 3
      #end
    end
    puts score
    return score
  end

  def dinner_name_slorg
    #return "wow"
    #puts dinner
    return ['Wednesday/Alice', 'Thursday/Space', 'Friday/Navy', 'Saturday 1/Pirates', 'Saturday 2/Crooners', 'Sunday/Bureaucracy', 'Monday/Crackpot', 'Pretentious'][dinner - 1]
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
    votes_copy = votes.map(&:value)
    @mean ||= votes_copy.inject(0) { |sum, x| sum += x } / votes_copy.size.to_f
  end

  def stdev_adj
    
    votes_copy = votes.map(&:value)
    for i in 1..art_votes
        votes_copy.push(2.5)
    end

    if(votes.length > 1)
      @stdev = Math.sqrt(votes_copy.inject(0) { |variance, x| variance += (x - mean) ** 2 } / (votes.length - 1 + art_votes))
    else
      0
    end
  end
  
  def stdev
    votes_copy = votes.map(&:value)
    #votes_copy.push(2.5)
    #votes_copy.push(2.5)
    #votes_copy.push(2.5)
    if(votes.length > 1)
      @stdev = Math.sqrt(votes_copy.inject(0) { |variance, x| variance += (x - mean) ** 2 } / (votes.length - 1))
    else
      0
    end
  end

  def art_votes
    3
  end

  def dinner_name
  end
end
