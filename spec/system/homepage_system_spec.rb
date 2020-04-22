require 'rails_helper'

RSpec.describe "Homepage", :type => :system do
    before do
        driven_by :selenium_chrome_headless
    end

    it "should direct me to the Locations index" do
        visit "/"
        expect(page).to have_current_path(locations_path)
    end
end
