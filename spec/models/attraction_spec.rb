require 'rails_helper'

RSpec.describe Attraction, type: :model do
    context 'when creating a new Attraction' do
        fixtures :locations
        fixtures :manufacturers
        fixtures :attraction_types

        it 'should not save without any values' do
            attraction = Attraction.new
            expect(attraction.save).to be_falsy
        end

        it 'should not save with only a name' do
            attraction = Attraction.new(name: 'my name')
            expect(attraction.save).to be_falsy
            
        end

        it 'should save with a name, location, manufacturer and attraction type' do
            attraction = Attraction.new(name: 'my name', 
                                        location: locations(:disneyland), 
                                        manufacturer: manufacturers(:manuf1),
                                        attraction_type: attraction_types(:rollercoaster))
            expect(attraction.save).to be_truthy
        end
    end

    context 'with a newly created Attraction' do
        fixtures :locations
        fixtures :manufacturers
        fixtures :attraction_types

        before(:each) do
            @attraction = Attraction.create!(   name: 'my name', 
                                                location: locations(:disneyland), 
                                                manufacturer: manufacturers(:manuf1),
                                                attraction_type: attraction_types(:rollercoaster))
        end

        it 'should convert top speed to mph' do
            @attraction.top_speed = 10
            @attraction.save
            expect(@attraction.top_speed_in_mph.round).to eq(22)
        end

        it 'should not convert unsupported attributes to mph' do
            @attraction.top_speed = 10
            @attraction.length = 50
            @attraction.height = 100
            @attraction.save
            expect{@attraction.name_in_mph}.to raise_error(ArgumentError)
            expect{@attraction.length_in_mph}.to raise_error(ArgumentError)
            expect{@attraction.height_in_mph}.to raise_error(ArgumentError)
        end

        it 'should convert height and length to ft' do
            @attraction.height = 10
            @attraction.length = 100
            @attraction.save
            expect(@attraction.height_in_ft.round).to eq(33)
            expect(@attraction.length_in_ft.round).to eq(328)
        end

        it 'should not convert unsupported attributes to ft' do
            @attraction.top_speed = 10
            @attraction.save
            expect{@attraction.name_in_ft}.to raise_error(ArgumentError)
            expect{@attraction.top_speed_in_ft}.to raise_error(ArgumentError)
        end
    end
end
