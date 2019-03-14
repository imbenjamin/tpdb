class Api::AttractionsController < ApplicationController
    def index
        render json: Attraction.all
    end

    def show
        render json: Attraction.find(params[:id])
    end
end
