require 'rails_helper'

RSpec.describe AttractionType, type: :model do
    context 'when creating a new AttractionType' do
        it 'should not save without a name' do
            attraction_type = AttractionType.new
            expect(attraction_type.save).to be_falsy
        end

        it 'should save with only a name' do
            attraction_type = AttractionType.new(name: 'my name')
            expect(attraction_type.save).to be_truthy
        end
    end

    context 'with a newly created AttractionType' do
        before(:each) do
            @attraction_type = AttractionType.create!(name: 'my name')
        end

        it 'should have an auto-generated slug' do
            expect(@attraction_type.slug).to eq('my-name')
        end

        it 'should update the slug when the name is updated' do
            @attraction_type.name = 'my new name'
            @attraction_type.save
            expect(@attraction_type.slug).to eq('my-new-name')
        end

        it 'should use the slug as param' do
            expect(@attraction_type.to_param).to eq('my-name')
        end
    end
end
