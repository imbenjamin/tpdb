class AreasController < ApplicationController

    def show
        @area = Area.find_by(slug: params[:slug])
        if !params[:location_slug]
            redirect_to location_area_path(location_slug: @area.location.slug)
        end
    end

    def new
        @area = Area.new

        if params[:location]
            params[:fixed_location] = true
            @area.location_id = params[:location]
        end
    end
    
    def edit
        @area = Area.find_by(slug: params[:slug])
    end

    def update
        @area = Area.find_by(slug: params[:slug])

        if @area.update(area_params)
            redirect_to @area
        else
            render 'edit'
        end
    end

    def area_params
        params.require(:area).permit(:name, :slug, :description, :location_id)
    end

end
