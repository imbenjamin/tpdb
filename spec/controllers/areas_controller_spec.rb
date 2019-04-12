require 'rails_helper'

RSpec.describe AreasController, type: :controller do
    describe 'GET show' do
        fixtures :areas
        fixtures :locations

        it 'should show a valid Area with a valid Area slug and valid Location slug' do
            area = areas(:tomorrowland)
            location = locations(:disneyland)
            request = get :show, :params => {:slug => area.slug, :location_slug => location.slug}
            expect(assigns(:area)).to eq(area)
            expect(request).to render_template(:show)
        end

        it 'should show a valid Area with only a valid Area slug' do
            area = areas(:tomorrowland)
            request = get :show, :params => {:slug => area.slug}
            expect(assigns(:area)).to eq(area)
            expect(request).to render_template(:show)
        end

        it 'should show a valid Area with a redirected Location given a valid Area slug and mismatched valid Location slug' do
            area = areas(:tomorrowland)
            mismatched_location = locations(:epcot)
            request = get :show, :params => {:slug => area.slug, :location_slug => mismatched_location.slug}
            expect(assigns(:area)).to eq(area)
            expect(controller.params[:location_slug]).to eq(area.location.slug)
            expect(controller.params[:location_slug]).to_not eq(mismatched_location.slug)
            expect(request).to render_template(:show)
            expect(flash[:notice]).to be_present
        end

        it 'should show a valid Area with a redirected Location given a valid Area slug and invalid Location slug' do
            area = areas(:tomorrowland)
            invalid_location_slug = "abcd1234"
            request = get :show, :params => {:slug => area.slug, :location_slug => invalid_location_slug}
            expect(assigns(:area)).to eq(area)
            expect(controller.params[:location_slug]).to eq(area.location.slug)
            expect(controller.params[:location_slug]).to_not eq(invalid_location_slug)
            expect(request).to render_template(:show)
            expect(flash[:notice]).to be_present
        end

        it 'should not show an invalid Area' do
            expect{get :show, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'GET new' do
        fixtures :locations
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should create a new Area if no parameters are predefined' do
            request = get :new
            expect(request).to render_template(:new)
            expect(assigns(:area)).to be_a_new(Area)
        end

        it 'should create a new Area if a valid Location is predefined' do
            location = locations(:disneyland)
            request = get :new, :params => {:location => location.id}
            expect(request).to render_template(:new)
            expect(assigns(:area)).to be_a_new(Area)
            expect(assigns(:area).location_id).to eq(location.id)
            expect(controller.params[:fixed_location]).to be true
        end

        it 'should create a new Area if an invalid Location is predefined' do
            request = get :new, :params => {:location => "abcd1234"}
            expect(request).to render_template(:new)
            expect(assigns(:area)).to be_a_new(Area)
            expect(assigns(:area).location_id).to be_nil
            expect(controller.params[:fixed_location]).to be_falsy
        end
    end

    describe 'GET edit' do
        fixtures :areas
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should render a valid Area' do
            area = areas(:tomorrowland)
            request = get :edit, :params => {:slug => area.slug}
            expect(request).to render_template(:edit)
            expect(assigns(:area)).to eq(area)
        end

        it 'should not render an invalid Attraction Type' do
            expect{get :edit, :params => {:slug => 'abcd1234'}}.to raise_error(ActionController::RoutingError)
            expect(flash[:error]).to be_present
        end
    end

    describe 'PATCH/PUT update' do
        fixtures :areas
        fixtures :locations
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should update a valid Area with valid params' do
            area = areas(:tomorrowland)
            new_name = 'my new name'
            request = patch :update, :params => {:slug => area.slug, :area => {:name => new_name, :location_id => area.location.id}}
            area = assigns(:area)
            expect(area.name).to eq(new_name)
            expect(request).to redirect_to(area_url(slug: area.slug))
        end

        it 'should not update a valid Area with invalid params' do
            area = areas(:tomorrowland)
            expect{patch :update, :params => {:slug => area.slug, :area => {:foo => 'bar'}}}.to raise_error(ActionController::UnpermittedParameters)
        end

        it 'should not update an invalid Area with valid params' do
            area_slug = 'abcd1234'
            new_name = 'my new name'
            expect{patch :update, :params => {:slug => area_slug, :area => {:name => new_name, :location_id => locations(:disneyland).id}}}.to raise_error(ActionController::RoutingError)
        end

        it 'should not update an invalid Area with invalid params' do
            area_slug = 'abcd1234'
            expect{patch :update, :params => {:slug => area_slug, :area => {:foo => 'bar'}}}.to raise_error(ActionController::RoutingError)
        end
    end

    describe 'DELETE destroy' do
        fixtures :areas
        fixtures :users

        before(:each) do
            sign_in users(:admin)
        end

        it 'should successfully delete a valid Area' do
            area = areas(:tomorrowland)
            expect{delete :destroy, :params => {:slug => area.slug}}.to change(Area, :count).by(-1)
        end

        it 'should silently fail to delete an invalid Area' do
            area_slug = 'abcd1234'
            expect{delete :destroy, :params => {:slug => area_slug}}.to_not change(Area, :count)
        end
    end
end
