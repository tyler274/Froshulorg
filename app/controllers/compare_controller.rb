class CompareController < ApplicationController
  def index
    #get the list of frosh for processing
    @froshes = Frosh.all
    #now we need to start our sorting process
    catch :notcompared do
      @sorted = merge_sort(@froshes);
    end
  end

  def merge_sort(a)
    return a if a.size <= 1
    l, r = split_array(a)
    result = combine(merge_sort(l), merge_sort(r))
  end

  def split_array a
    mid = (a.size / 2).round
    [a.take(mid), a.drop(mid)]
  end

  def combine a, b
    return b.empty? ? a : b if a.empty? || b.empty?
    #find out which is better
    #is a better?
    if Comparison.where(:winner=>a.first.id).
                    where(:loser=>b.first.id).count != 0
      smallest = a.shift
    elsif Comparison.where(:winner=>b.first.id).
                    where(:loser=>a.first.id).count != 0
      smallest = b.shift
    else
      #they have not been compared, we must compare them
      redirect_to action: "compare", left:a.first.id, right:b.first.id
      throw :notcompared
    end
    #smallest = a.first <= b.first ? a.shift : b.shift
    combine(a, b).unshift(smallest)
  end

  def compare
    @leftfrosh = Frosh.find(params[:left])
    @rightfrosh = Frosh.find(params[:right])
    #TODO render frosh data
  end

  def savecmp
    winnerid = params[:winner]
    loserid = params[:loser]
    if Comparison.where(:winner=>winnerid).
                      where(:loser=>loserid).count == 0  &&
              Comparison.where(:winner=>loserid).
                      where(:loser=>winnerid).count == 0
      @comparison = Comparison.new
      @comparison.winner = winnerid
      @comparison.loser = loserid
  
      @comparison.save
  
      
      redirect_to action: "index"
    else
      render text: "plz don't do that"
    end
  end
  
  def list
  	@comparisons = Comparison.all
  end

  def delete
  	Comparison.find(params[:id]).destroy()
	redirect_to action: "list"
  end
end
