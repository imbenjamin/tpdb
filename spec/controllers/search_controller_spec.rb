require 'rails_helper'

RSpec.describe SearchController, type: :controller do
    describe 'GET new' do
        fixtures :attractions
        fixtures :locations

        it 'should accept missing q query string' do
            request = get :new
            expect(request).to render_template('search/result')
            expect(assigns(:r_attractions)).to be_nil
            expect(assigns(:r_locations)).to be_nil
        end

        it 'should build a search result given a matched query' do
            request = get :new, :params => {:q => 'disney'}
            expect(request).to render_template('search/result')
            expect(assigns(:r_attractions)).to_not be_nil
            expect(assigns(:r_locations)).to_not be_nil
            expect(assigns(:r_attractions).any?).to be_truthy
            expect(assigns(:r_locations).any?).to be_truthy
        end

        it 'should build an empty search result given a mismatched query' do
            request = get :new, :params => {:q => 'asdfghjkl'}
            expect(request).to render_template('search/result')
            expect(assigns(:r_attractions)).to_not be_nil
            expect(assigns(:r_locations)).to_not be_nil
            expect(assigns(:r_attractions).any?).to be_falsy
            expect(assigns(:r_locations).any?).to be_falsy
        end
    end
end
