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
        begin
            @location = Location.find_by!(slug: params[:slug])
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Location not found"
            return not_found
        end
    end

    def update
        begin
            @location = Location.find_by!(slug: params[:slug])

            if @location.update(location_params)
                redirect_to @location
            else
                render 'edit'
            end
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Location not found"
            return not_found
        end
    end

    def show
        begin
            @location = Location.find_by!(slug: params[:slug])
            @attractions_without_area = Attraction.where(location: @location, area: nil)
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Location not found"
            return not_found
        end
    end

    def destroy
        if @location = Location.find_by(slug: params[:slug])
            @location.destroy
        end

        redirect_to locations_path
    end

    private
    def location_params
        params.require(:location).permit(:name, :slug, :parent_id, :description, :address, :latitude, :longitude, :logo, :city, :state, :country)
    end
end
