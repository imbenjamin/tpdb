require 'rails_helper'

RSpec.describe ManufacturersController, type: :controller do
    describe 'GET index' do
        fixtures :manufacturers

        it 'should render all manufacturers' do
            request = get :index
            expect(request).to render_template('manufacturers/index')
            expect(assigns(:manufacturers)).to_not be_nil
        end
    end

    describe 'GET show' do
        fixtures :manufacturers

        it 'should render a valid manufacturer' do
            request = get :show, :params => {:slug => manufacturers(:manuf1).slug}
            expect(request).to render_template('manufacturers/show')
        end

        it 'should render a 404 with an invalid manufacturer' do
            expect{get :show, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
        end
    end
end
