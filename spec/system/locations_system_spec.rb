require 'rails_helper'

RSpec.describe "Locations", :type => :system do
    fixtures :locations
    
    before do
        driven_by :selenium_chrome_headless
    end

    describe 'page header' do
        it "should have a top menu" do
            visit locations_path
            expect(page).to have_selector('header nav')
        end
    end

    describe 'page main' do
        it "should have a body" do
            visit locations_path
            expect(page).to have_selector('main')
        end

        it "should have a header" do
            visit locations_path
            expect(page).to have_selector('main h1')
        end

        it "should have a table" do
            visit locations_path
            expect(page).to have_selector('main table')
        end
    end

    describe 'page footer' do
        it "should have a footer" do
            visit locations_path
            expect(page).to have_selector('footer')
        end
    end
end
