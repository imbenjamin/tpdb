class AttractionTypesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @attraction_types = AttractionType.all
    end
    
    def new
        @attraction_type = AttractionType.new
    end

    def create
        @attraction_type = AttractionType.new(attraction_type_params)

        if @attraction_type.save
            redirect_to @attraction_type
        else
            render 'new'
        end
    end

    def edit
        begin
            @attraction_type = AttractionType.find_by!(slug: params[:slug])
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Attraction Type not found"
            return not_found
        end
    end

    def update
        begin
            @attraction_type = AttractionType.find_by!(slug: params[:slug])

            if @attraction_type.update(attraction_type_params)
                redirect_to @attraction_type
            else
                render 'edit'
            end
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Attraction Type not found"
            return not_found
        end
    end

    def show
        begin
            @attraction_type = AttractionType.find_by!(slug: params[:slug])
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Attraction Type not found"
            return not_found
        end
    end

    def destroy
        if @attraction_type = AttractionType.find_by(slug: params[:slug])
            @attraction_type.destroy
        end

        redirect_to attraction_types_path
    end

    private
    def attraction_type_params
        params.require(:attraction_type).permit(:name, :description, :slug)
    end
end
