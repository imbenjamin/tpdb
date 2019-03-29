require 'rails_helper'

RSpec.describe AttractionTypesController, type: :controller do
    describe 'GET index' do
        it 'should render all Attraction Types' do
            request = get :index
            expect(request).to render_template(:index)
            expect(assigns(:attraction_types)).to_not be_nil
        end
    end

    describe 'GET new' do
        it 'should create a new Attraction Type' do
            request = get :new
            expect(request).to render_template(:new)
            expect(assigns(:attraction_type)).to be_a_new(AttractionType)
        end
    end

    describe 'POST create' do
        it 'should save a new Attraction Type with valid params' do
            request = post :create, :params => {:attraction_type => { :name => 'my name' }}
            expect(assigns(:attraction_type)).to_not be_nil
            expect(request).to redirect_to(:action => :show, :slug => assigns(:attraction_type).slug)
        end

        it 'should not save a new Attraction Type with invalid params' do
            expect{post :create, :params => {:attraction_type => { }}}.to raise_error(ActionController::ParameterMissing)
        end
    end

    describe 'GET edit' do
        fixtures :attraction_types

        it 'should render a valid Attraction Type' do
            attraction_type = attraction_types(:rollercoaster)
            request = get :edit, :params => {:slug => attraction_type.slug}
            expect(request).to render_template(:edit)
            expect(assigns(:attraction_type)).to eq(attraction_type)
        end

        it 'should not render an invalid Attraction Type' do
            expect{get :edit, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'PATCH/PUT update' do
        fixtures :attraction_types

        it 'should update a valid Attraction Type with valid params' do
            attraction_type = attraction_types(:rollercoaster)
            new_name = 'my new name'
            request = patch :update, :params => {:slug => attraction_type.slug, :attraction_type => {:name => new_name}}
            attraction_type = assigns(:attraction_type)
            expect(attraction_type.name).to eq(new_name)
            expect(request).to redirect_to(attraction_type_url(slug: attraction_type.slug))
        end

        it 'should not update a valid Attraction Type with invalid params' do
            attraction_type = attraction_types(:rollercoaster)
            expect{patch :update, :params => {:slug => attraction_type.slug, :attraction_type => {:foo => 'bar'}}}.to raise_error(ActionController::UnpermittedParameters)
        end

        it 'should not update an invalid Attraction Type with valid params' do
            attraction_type_slug = 'abcd1234'
            new_name = 'my new name'
            expect{patch :update, :params => {:slug => attraction_type_slug, :attraction_type => {:name => new_name}}}.to raise_error(ActionController::RoutingError)
        end

        it 'should not update an invalid Attraction Type with invalid params' do
            attraction_type_slug = 'abcd1234'
            expect{patch :update, :params => {:slug => attraction_type_slug, :attraction_type => {:foo => 'bar'}}}.to raise_error(ActionController::RoutingError)
        end
    end

    describe 'GET show' do
        fixtures :attraction_types

        it 'should render a valid Attraction Type' do
            attraction_type = attraction_types(:rollercoaster)
            request = get :show, :params => {:slug => attraction_type.slug}
            expect(assigns(:attraction_type)).to eq(attraction_type)
            expect(request).to render_template(:show)
        end

        it 'should not render an invalid Attraction Type' do
            expect{get :show, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'DELETE destroy' do
        fixtures :attraction_types

        it 'should successfully delete a valid Attraction Type' do
            attraction_type = attraction_types(:rollercoaster)
            expect{delete :destroy, :params => {:slug => attraction_type.slug}}.to change(AttractionType, :count).by(-1)
        end

        it 'should silently fail to delete an invalid Attraction Type' do
            attraction_type_slug = 'abcd1234'
            expect{delete :destroy, :params => {:slug => attraction_type_slug}}.to_not change(AttractionType, :count)
        end
    end
end
