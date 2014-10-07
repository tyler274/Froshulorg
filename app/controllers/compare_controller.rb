class CompareController < ApplicationController
  def index
    #get the list of frosh for processing
    @froshes = Frosh.ordered
    #now we need to start our sorting process
    catch :notcompared do
      #@sorted = merge_sort(@froshes);
      @sorted = bubble_sort(@froshes, 50);
      @sorted = bubble_sort(@froshes, 100);
      @sorted = bubble_sort(@froshes, 150);
      #@sorted = @froshes

      respond_to do |format|
        format.html
        format.csv do
          text = ""
          @sorted.each_index do |index|
            thisfrosh = @sorted[index]
            text = text + thisfrosh.name + ',' + 'fuck' + ',' + thisfrosh.dinner_name_slorg + ',' + thisfrosh.image_url + ',' + 'urlurl' + ',' + thisfrosh.color \
                + ',' + thisfrosh.mean.to_s + ',' + thisfrosh.stdev.to_s + ',' + thisfrosh.votes.length.to_s + '#slorg' + "\n"
          end
          render :text => text
        end
      end
    end
  end

  def bubble_sort a, limit
    n = limit#a.length
    swapped = true
    while swapped  do
      swapped = false
      (1..n-1).each do |i|
        if sort_compare(a[i], a[i - 1])
          temp = a[i]
          a[i] = a[i - 1]
          a[i - 1] = temp

          n = i
          swapped = true
        end
      end
    end
    return a
  end

  def merge_sort(a)
    return a if a.size <= 1
    l, r = split_array(a)
    combine(merge_sort(l), merge_sort(r))
  end

  def split_array a
    mid = (a.size / 2).round
    [a.take(mid), a.drop(mid)]
  end

  def combine a, b
    return b.empty? ? a : b if a.empty? || b.empty?
    #find out which is better
    #is a better?
    if sort_compare(a.first, b.first)
      smallest = a.shift
    else
      smallest = b.shift
    end
    #smallest = a.first <= b.first ? a.shift : b.shift
    combine(a, b).unshift(smallest)
  end

  def sort_compare a, b
    if Comparison.where(:winner_id=>a.id).
                    where(:loser_id=>b.id).count != 0
      return true
    elsif Comparison.where(:winner_id=>b.id).
                    where(:loser_id=>a.id).count != 0
      return false
    else
      #they have not been compared, we must compare them
      redirect_to action: "compare", left:a.id, right:b.id
      throw :notcompared
    end
  end

  def compare
    @leftfrosh = Frosh.find(params[:left])
    @rightfrosh = Frosh.find(params[:right])
    #TODO render frosh data
  end

  def savecmp
    winnerid = params[:winner]
    loserid = params[:loser]
    if Comparison.where(:winner_id=>winnerid).
                      where(:loser_id=>loserid).count == 0  &&
              Comparison.where(:winner_id=>loserid).
                      where(:loser_id=>winnerid).count == 0
      @comparison = Comparison.new
      @comparison.winner_id = winnerid
      @comparison.loser_id = loserid
  
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
