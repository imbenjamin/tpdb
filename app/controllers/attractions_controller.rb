class AttractionsController < ApplicationController
    def index
        @attractions = Attraction.all
    end
    
    def new
        @attraction = Attraction.new

        if params[:location]
            params[:fixed_location] = true
            @attraction.location_id = params[:location]
        end
        
        if params[:area]
            params[:fixed_area] = true
            @attraction.area_id = params[:area]
        end
    end

    def create
        @attraction = Attraction.new(attraction_params)

        if @attraction.save
            redirect_to @attraction
        else
            render 'new'
        end
    end

    def edit
        @attraction = Attraction.find_by(slug: params[:slug])
    end

    def update
        @attraction = Attraction.find_by(slug: params[:slug])

        if @attraction.update(attraction_params)
            redirect_to @attraction
        else
            render 'edit'
        end
    end

    def show
        @attraction = Attraction.find_by(slug: params[:slug])
        if !params[:location_slug]
            redirect_to location_attraction_path(location_slug: @attraction.location.slug)
        end
    end

    def destroy
        @attraction = Attraction.find_by(slug: params[:slug])
        @attraction.destroy

        redirect_to attractions_path
    end

    private
    def attraction_params
        params.require(:attraction).permit(:name, :slug, :description, :height, :length, :top_speed, :capacity, :inversions, :attraction_type_id, :location_id, :area_id)
    end
end
