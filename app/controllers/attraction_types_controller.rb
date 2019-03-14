class AttractionTypesController < ApplicationController
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
        @attraction_type = AttractionType.find_by(slug: params[:slug])
    end

    def update
        @attraction_type = AttractionType.find_by(slug: params[:slug])

        if @attraction_type.update(attraction_type_params)
            redirect_to @attraction_type
        else
            render 'edit'
        end
    end

    def show
        @attraction_type = AttractionType.find_by(slug: params[:slug])
    end

    def destroy
        @attraction_type = AttractionType.find_by(slug: params[:slug])
        @attraction_type.destroy

        redirect_to attraction_types_path
    end

    private
    def attraction_type_params
        params.require(:attraction_type).permit(:name, :slug)
    end
end
