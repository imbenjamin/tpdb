class SearchController < ApplicationController
    def new
        if params[:q]
            @r_attractions = Attraction.ransack(name_cont: params[:q]).result(distinct: true)
            @r_locations = Location.ransack(name_cont: params[:q]).result(distinct: true)
            @r_areas = Area.ransack(name_cont: params[:q]).result(distinct: true)
        end
        render 'result'
    end
end
