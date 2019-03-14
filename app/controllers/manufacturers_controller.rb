class ManufacturersController < ApplicationController
    def index
        @manufacturers = Manufacturer.all
    end
    
    def show
        @manufacturer = Manufacturer.find_by(slug: params[:slug])
    end
end
