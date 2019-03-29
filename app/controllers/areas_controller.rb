class AreasController < ApplicationController

    def show
        begin
            @area = Area.find_by!(slug: params[:slug])
            if !params[:location_slug]
                params[:location_slug] = @area.location.slug
            elsif params[:location_slug] != @area.location.slug
                params[:location_slug] = @area.location.slug
                flash[:notice] = "The Area given did not match the Location given, redirected to the correct Location"
            end
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Area not found"
            return not_found
        end
    end

    def new
        @area = Area.new

        if params[:location] && Location.find_by(id: params[:location])
            params[:fixed_location] = true
            @area.location_id = params[:location]
        end
    end
    
    def edit
        begin
            @area = Area.find_by!(slug: params[:slug])
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Area not found"
            return not_found
        end
    end

    def update
        begin
            @area = Area.find_by!(slug: params[:slug])
            if @area.update(area_params)
                redirect_to @area
            else
                render 'edit'
            end
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Area not found"
            return not_found
        end
    end

    def destroy
        if @area = Area.find_by(slug: params[:slug])
            @area.destroy
        end

        redirect_to areas_path
    end

    def area_params
        params.require(:area).permit(:name, :slug, :description, :location_id)
    end

end
