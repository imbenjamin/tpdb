require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
    describe 'GET index' do
        fixtures :locations

        it 'should render all Locations' do
            request = get :index
            expect(request).to render_template(:index)
            expect(assigns(:locations)).to_not be_nil
        end
    end

    describe 'GET new' do
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should create a new Location' do
            request = get :new
            expect(request).to render_template(:new)
            expect(assigns(:location)).to be_a_new(Location)
        end
    end

    describe 'POST create' do
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should save a new Location with valid params' do
            request = post :create, :params => {:location => { :name => 'my name' }}
            expect(assigns(:location)).to_not be_nil
            expect(request).to redirect_to(:action => :show, :slug => assigns(:location).slug)
        end

        it 'should not save a new Location with invalid params' do
            expect{post :create, :params => {:location => { }}}.to raise_error(ActionController::ParameterMissing)
        end
    end

    describe 'GET edit' do
        fixtures :locations
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should render template for a valid Location' do
            request = get :edit, :params => {:slug => locations(:disneyland).slug}
            expect(request).to render_template(:edit)
            expect(assigns(:location)).to eq(locations(:disneyland))
        end

        it 'should render a 404 for an invalid Location' do
            expect{get :edit, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'PATCH/PUT update' do
        fixtures :locations
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should update a valid Location with valid params' do
            location = locations(:disneyland)
            new_name = 'my new name'
            request = patch :update, :params => {:slug => location.slug, :location => {:name => new_name}}
            location = assigns(:location)
            expect(location.name).to eq(new_name)
            expect(request).to redirect_to(location_url(slug: location.slug))
        end

        it 'should not update a valid Location with invalid params' do
            location = locations(:disneyland)
            expect{patch :update, :params => {:slug => location.slug, :location => {:foo => 'bar'}}}.to raise_error(ActionController::UnpermittedParameters)
        end

        it 'should not update an invalid Location with valid params' do
            location_slug = 'abcd1234'
            new_name = 'my new name'
            expect{patch :update, :params => {:slug => location_slug, :location => {:name => new_name}}}.to raise_error(ActionController::RoutingError)
        end

        it 'should not update an invalid Location with invalid params' do
            location_slug = 'abcd1234'
            expect{patch :update, :params => {:slug => location_slug, :location => {:foo => 'bar'}}}.to raise_error(ActionController::RoutingError)
        end
    end

    describe 'GET show' do
        fixtures :locations

        it 'should render a valid Location' do
            location = locations(:disneyland)
            request = get :show, :params => {:slug => location.slug}
            expect(assigns(:location)).to eq(location)
            expect(request).to render_template(:show)
        end

        it 'should not render an invalid Location' do
            expect{get :show, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'DELETE destroy' do
        fixtures :locations
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should successfully delete a valid Location' do
            location = locations(:disneyland)
            expect{delete :destroy, :params => {:slug => location.slug}}.to change(Location, :count).by(-1)
        end

        it 'should silently fail to delete an invalid Location' do
            location_slug = 'abcd1234'
            expect{delete :destroy, :params => {:slug => location_slug}}.to_not change(Location, :count)
        end
    end
end
