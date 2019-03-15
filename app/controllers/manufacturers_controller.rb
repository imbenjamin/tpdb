class ManufacturersController < ApplicationController
    def index
        @manufacturers = Manufacturer.all
    end
    
    def show
        begin
            @manufacturer = Manufacturer.find_by!(slug: params[:slug])
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Manufacturer not found"
            return not_found
        end
    end
end
