require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
    describe 'GET index' do
        fixtures :locations

        it 'should render all locations' do
            request = get :index
            expect(request).to render_template(:index)
            expect(assigns(:locations)).to_not be_nil
        end
    end

    describe 'GET new' do
        it 'should create a new Location' do
            request = get :new
            expect(request).to render_template(:new)
            expect(assigns(:location)).to be_a_new(Location)
        end
    end

    describe 'POST create' do
        fixtures :locations

        it 'should save a new Location with valid params' do
            request = post :create, :params => {:location => { :name => 'my name' }}
            expect(assigns(:location)).to_not be_nil
            expect(request).to redirect_to(:action => :show, :slug => assigns(:location).slug)
        end

        it 'should not save a new Location with invalid params' do
            expect{post :create, :params => {:location => { }}}.to raise_error(ActionController::ParameterMissing)
        end
    end
end
