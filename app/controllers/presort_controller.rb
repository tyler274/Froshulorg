class PresortController < ApplicationController
    def index
        @froshes = Frosh.ordered
        @positions = []
        @froshes.each_index do |idx|
            @positions.push([idx.to_s + "-" + @froshes[idx].name, @froshes[idx].id])
        end
    end

    def update
        frosh = Frosh.find(params[:id])
        old_frosh = Frosh.find(params[:frosh][:prelim_rank])
        frosh.list = old_frosh.list
        frosh.save
        if frosh != old_frosh.previous
            if old_frosh.first?
                frosh.prepend
            else
                frosh.append_to old_frosh.previous
            end
        end
        #somehow update the ranking somehow
        redirect_to presort_index_path
    end

    def new
        froshes = Frosh.all
        #sort the array by the prelim score
        froshes.sort! { |b, a| a.prelim_score <=> b.prelim_score }
        prev = false
        froshes.each do |frosh|
            if prev
                frosh.append_to prev
                prev = frosh
            else
                frosh.update_attribute(:first, true)
                prev = frosh
            end
        end
        redirect_to presort_index_path
    end

    def apply_cutoffs
        green = params[:green].to_i
        blue = params[:blue].to_i
        froshes = Frosh.ordered
        froshes.each_index do |index|
            if index < green
                froshes[index].list = 0
            elsif index < blue
                froshes[index].list = 1
            else
                froshes[index].list = 2
            end
            froshes[index].save
        end
        redirect_to presort_index_path
    end
end
