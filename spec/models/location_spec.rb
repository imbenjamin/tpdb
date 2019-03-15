require 'rails_helper'

RSpec.describe Location, type: :model do
    context 'when creating a new Location' do
        it 'should not save without any values' do
            location = Location.new
            expect(location.save).to be_falsy
        end

        it 'should not save with only a name <5 chars' do
            location = Location.new(name: 'name')
            expect(location.save).to be_falsy
        end

        it 'should save with only a name (>5 chars)' do
            location = Location.new(name: 'my name')
            expect(location.save).to be_truthy
        end

        it 'should save with a parent location' do
            parent = Location.create!(name: 'parent location')
            child = Location.new(name: 'child location', parent_id: parent.id)
            expect(child.save).to be_truthy
            expect(child.parent).to eq(parent)
        end
    end

    context 'with a newly created Location' do
        before(:each) do
            @location = Location.create!(name: 'my name')
        end
        before(:all) do 
            Geocoder.configure(:lookup => :test)
          
            Geocoder::Lookup::Test.add_stub(
                '1313 Disneyland Dr, Anaheim, CA 92802, USA', [
                    {
                        'coordinates'  => [33.8153959, -117.9263991],
                        'address'      => '1313 Disneyland Dr, Anaheim, CA 92802, USA',
                        'city'         => 'Anaheim',
                        'state'        => 'California',
                        'state_code'   => 'CA',
                        'country'      => 'United States',
                        'country_code' => 'US'
                    }
                ]
            )
            Geocoder::Lookup::Test.add_stub(
                '1180 Seven Seas Dr, Lake Buena Vista, FL 32830, USA', [
                    {
                        'coordinates'  => [28.417831662, -81.575331032],
                        'address'      => '1180 Seven Seas Dr, Lake Buena Vista, FL 32830, USA',
                        'city'         => 'Lake Buena Vista',
                        'state'        => 'Florida',
                        'state_code'   => 'FL',
                        'country'      => 'United States',
                        'country_code' => 'US'
                    }
                ]
            )
        end

        it 'should have an auto-generated slug' do
            expect(@location.slug).to eq('my-name')
        end

        it 'should update the slug when the name is updated' do
            @location.name = 'my new name'
            @location.save
            expect(@location.slug).to eq('my-new-name')
        end

        it 'should use the slug as param' do
            expect(@location.to_param).to eq('my-name')
        end

        it 'should geocode an address' do
            @location.address = '1313 Disneyland Dr, Anaheim, CA 92802, USA'
            @location.save
            expect(@location.latitude).to eq(33.8153959)
            expect(@location.longitude).to eq(-117.9263991)
            expect(@location.city).to eq('Anaheim')
            expect(@location.state).to eq('California')
            expect(@location.country).to eq('United States')
        end

        it 'should re-geocode if the address is changed' do
            @location.address = '1313 Disneyland Dr, Anaheim, CA 92802, USA'
            @location.save
            @location.address = '1180 Seven Seas Dr, Lake Buena Vista, FL 32830, USA'
            @location.save
            expect(@location.latitude).to eq(28.417831662)
            expect(@location.longitude).to eq(-81.575331032)
            expect(@location.city).to eq('Lake Buena Vista')
            expect(@location.state).to eq('Florida')
            expect(@location.country).to eq('United States')
        end
    end
end
