class AttractionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @attractions = Attraction.all
    end
    
    def new
        @attraction = Attraction.new

        if params[:location] && !params[:area]
            if Location.find_by(id: params[:location])
                params[:fixed_location] = true
                @attraction.location_id = params[:location]
            else
                flash[:error] = "Unable to find the requested location, sorry!"
            end
        end
        
        if params[:area]
            if area = Area.find_by(id: params[:area])
                params[:fixed_area] = true
                @attraction.area_id = params[:area]
                params[:fixed_location] = true
                @attraction.location_id = area.location.id
                if params[:location] && params[:location] != area.location.id
                    flash[:notice] = "The given location did not match the given area's location, so we're using the area's location"
                end
            else
                flash[:error] = "Unable to find the requested area, sorry!"
            end
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
        begin
            @attraction = Attraction.find_by!(slug: params[:slug])
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Attraction not found"
            return not_found
        end
    end

    def update
        begin
            @attraction = Attraction.find_by!(slug: params[:slug])

            if @attraction.update(attraction_params)
                redirect_to @attraction
            else
                render 'edit'
            end
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Attraction not found"
            return not_found
        end
    end

    def show
        begin
            @attraction = Attraction.find_by!(slug: params[:slug])
            
            if !params[:location_slug]
                params[:location_slug] = @attraction.location.slug
            elsif params[:location_slug] != @attraction.location.slug
                params[:location_slug] = @attraction.location.slug
                flash[:notice] = "The Attraction given did not match the Location given, redirected to the correct Location"
            end
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Attraction not found"
            return not_found
        end
    end

    def destroy
        if @attraction = Attraction.find_by(slug: params[:slug])
            @attraction.destroy
        end

        redirect_to attractions_path
    end

    private
    def attraction_params
        params.require(:attraction).permit(:name, :slug, :description, :height, :length, :top_speed, :capacity, :inversions, :attraction_type_id, :location_id, :area_id, :manufacturer_id)
    end
end
