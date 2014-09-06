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
        if old_frosh.first?
            frosh.prepend
        else
            frosh.append_to old_frosh.previous
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
end
