require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
    describe 'GET index' do
        it 'redirects to locations index' do
            request = get :index
            expect(request).to redirect_to(:controller => :locations,
                                            :action => :index)
        end
    end
end
