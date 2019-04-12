require 'rails_helper'

RSpec.describe AttractionsController, type: :controller do
    describe 'GET index' do
        it 'should render all Attractions' do
            request = get :index
            expect(request).to render_template(:index)
            expect(assigns(:attractions)).to_not be_nil
        end
    end

    describe 'GET new' do
        fixtures :locations
        fixtures :areas
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should create a new Attraction without predefined Location or Area' do
            request = get :new
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(flash[:error]).to_not be_present
            expect(flash[:notice]).to_not be_present
        end

        it 'should create a new Attraction with predefined valid Location and no Area' do
            location = locations(:disneyland)
            request = get :new, :params => {:location => location.id}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).location).to eq(location)
            expect(flash[:error]).to_not be_present
            expect(flash[:notice]).to_not be_present
        end

        it 'should create a new Attraction with predefined invalid Location and no Area' do
            request = get :new, :params => {:location => "abcd1234"}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).location).to be_nil
            expect(flash[:error]).to be_present
            expect(flash[:notice]).to_not be_present
        end

        it 'should create a new Attraction with predefined valid Area but no Location' do
            request = get :new, :params => {:area => areas(:tomorrowland).id}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).area).to eq(areas(:tomorrowland))
            expect(assigns(:attraction).location).to eq(areas(:tomorrowland).location)
            expect(flash[:error]).to_not be_present
            expect(flash[:notice]).to_not be_present
        end

        it 'should create a new Attraction with predefined invalid Area and no Location' do
            request = get :new, :params => {:area => "abcd1234"}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).area).to be_nil
            expect(assigns(:attraction).location).to be_nil
            expect(flash[:error]).to be_present
            expect(flash[:notice]).to_not be_present
        end

        it 'should create a new Attraction with predefined valid Location and matching valid Area' do
            request = get :new, :params => {:area => areas(:tomorrowland).id, :location => areas(:tomorrowland).location.id}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).area).to eq(areas(:tomorrowland))
            expect(assigns(:attraction).location).to eq(areas(:tomorrowland).location)
            expect(flash[:error]).to_not be_present
            expect(flash[:notice]).to_not be_present
        end

        it 'should create a new Attraction with predefined valid Location but mismatched valid Area' do
            request = get :new, :params => {:area => areas(:theland).id, :location => locations(:disneyland).id}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).area).to eq(areas(:theland))
            expect(assigns(:attraction).location).to eq(areas(:theland).location)
            expect(assigns(:attraction).location).to_not eq(locations(:disneyland))
            expect(flash[:error]).to_not be_present
            expect(flash[:notice]).to be_present
        end

        it 'should create a new Attraction with predefined invalid Location and invalid Area' do
            request = get :new, :params => {:area => "abcd1234", :location => "abcd4321"}
            expect(request).to render_template(:new)
            expect(assigns(:attraction)).to be_a_new(Attraction)
            expect(assigns(:attraction).area).to be_nil
            expect(assigns(:attraction).location).to be_nil
            expect(flash[:error]).to be_present
            expect(flash[:notice]).to_not be_present
        end
    end

    describe 'POST create' do
        fixtures :locations
        fixtures :attraction_types
        fixtures :manufacturers
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should save a new Attraction with valid params' do
            request = post :create, :params => {:attraction => { :name => 'my name', :location_id => locations(:disneyland).id, :attraction_type_id =>  attraction_types(:rollercoaster).id, :manufacturer_id => manufacturers(:manuf1).id}}
            expect(assigns(:attraction)).to_not be_nil
            expect(request).to redirect_to(:action => :show, :slug => assigns(:attraction).slug)
        end

        it 'should not save a new Attraction with invalid params' do
            expect{post :create, :params => {:attraction => { }}}.to raise_error(ActionController::ParameterMissing)
        end
    end

    describe 'GET edit' do
        fixtures :attractions
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should render a valid Attraction' do
            attraction = attractions(:spacemountain)
            request = get :edit, :params => {:slug => attraction.slug}
            expect(request).to render_template(:edit)
            expect(assigns(:attraction)).to eq(attraction)
        end

        it 'should not render an invalid Attraction' do
            expect{get :edit, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'PATCH/PUT update' do
        fixtures :attractions
        fixtures :locations
        fixtures :manufacturers
        fixtures :attraction_types
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should update a valid Attraction with valid params' do
            attraction = attractions(:spacemountain)
            new_name = 'my new name'
            valid_params = {:name => new_name, :location_id => attraction.location.id, :attraction_type_id => attraction.attraction_type.id, :manufacturer_id => attraction.manufacturer.id}
            request = patch :update, :params => {:slug => attraction.slug, :attraction => valid_params}
            attraction = assigns(:attraction)
            expect(attraction.name).to eq(new_name)
            expect(request).to redirect_to(attraction_url(slug: attraction.slug))
        end

        it 'should not update a valid Attraction with invalid params' do
            attraction = attractions(:spacemountain)
            expect{patch :update, :params => {:slug => attraction.slug, :attraction => {:foo => 'bar'}}}.to raise_error(ActionController::UnpermittedParameters)
        end

        it 'should not update an invalid Attraction with valid params' do
            attraction_slug = 'abcd1234'
            new_name = 'my new name'
            valid_params = {:name => new_name, :location_id => locations(:disneyland).id, :attraction_type_id => attraction_types(:rollercoaster).id, :manufacturer_id => manufacturers(:manuf1).id}
            expect{patch :update, :params => {:slug => attraction_slug, :attraction => valid_params}}.to raise_error(ActionController::RoutingError)
        end

        it 'should not update an invalid Attraction with invalid params' do
            attraction_slug = 'abcd1234'
            expect{patch :update, :params => {:slug => attraction_slug, :attraction => {:foo => 'bar'}}}.to raise_error(ActionController::RoutingError)
        end
    end

    describe 'GET show' do
        fixtures :attractions
        fixtures :locations

        it 'should show a valid Attraction with a valid Attraction slug and valid Location slug' do
            attraction = attractions(:spacemountain)
            location = locations(:disneyland)
            request = get :show, :params => {:slug => attraction.slug, :location_slug => location.slug}
            expect(assigns(:attraction)).to eq(attraction)
            expect(request).to render_template(:show)
        end

        it 'should show a valid Attraction with only a valid Attraction slug' do
            attraction = attractions(:spacemountain)
            request = get :show, :params => {:slug => attraction.slug}
            expect(assigns(:attraction)).to eq(attraction)
            expect(request).to render_template(:show)
        end

        it 'should show a valid Attraction with a redirected Location given a valid Attraction slug and mismatched valid Location slug' do
            attraction = attractions(:spacemountain)
            mismatched_location = locations(:epcot)
            request = get :show, :params => {:slug => attraction.slug, :location_slug => mismatched_location.slug}
            expect(assigns(:attraction)).to eq(attraction)
            expect(controller.params[:location_slug]).to eq(attraction.location.slug)
            expect(controller.params[:location_slug]).to_not eq(mismatched_location.slug)
            expect(request).to render_template(:show)
            expect(flash[:notice]).to be_present
        end

        it 'should show a valid Attraction with a redirected Location given a valid Attraction slug and invalid Location slug' do
            attraction = attractions(:spacemountain)
            invalid_location_slug = "abcd1234"
            request = get :show, :params => {:slug => attraction.slug, :location_slug => invalid_location_slug}
            expect(assigns(:attraction)).to eq(attraction)
            expect(controller.params[:location_slug]).to eq(attraction.location.slug)
            expect(controller.params[:location_slug]).to_not eq(invalid_location_slug)
            expect(request).to render_template(:show)
            expect(flash[:notice]).to be_present
        end

        it 'should not show an invalid Attraction' do
            expect{get :show, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'DELETE destroy' do
        fixtures :attractions
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should successfully delete a valid Attraction' do
            attraction = attractions(:spacemountain)
            expect{delete :destroy, :params => {:slug => attraction.slug}}.to change(Attraction, :count).by(-1)
        end

        it 'should silently fail to delete an invalid Attraction' do
            attraction_slug = 'abcd1234'
            expect{delete :destroy, :params => {:slug => attraction_slug}}.to_not change(Attraction, :count)
        end
    end
end
