class LocationsController < ApplicationController
    def index
        @locations = Location.all
    end
    
    def new
        @location = Location.new
    end

    def create
        @location = Location.new(location_params)

        if @location.save
            redirect_to @location
        else
            render 'new'
        end
    end

    def edit
        @location = Location.find_by(slug: params[:slug])
    end

    def update
        @location = Location.find_by(slug: params[:slug])

        if @location.update(location_params)
            redirect_to @location
        else
            render 'edit'
        end
    end

    def show
        @location = Location.find_by(slug: params[:slug])
        @attractions_without_area = Attraction.where(location: @location, area: nil)
    end

    def destroy
        @location = Location.find_by(slug: params[:slug])
        @location.destroy

        redirect_to locations_path
    end

    private
    def location_params
        params.require(:location).permit(:name, :slug, :parent_id, :description, :address, :latitude, :longitude, :logo)
    end
end
