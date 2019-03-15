require 'rails_helper'

RSpec.describe Area, type: :model do
    context 'when creating a new Area' do
        fixtures :locations

        it 'should not save without any values' do
            area = Area.new
            expect(area.save).to be_falsy
        end

        it 'should not save with only a name' do
            area = Area.new(name: 'my name')
            expect(area.save).to be_falsy
            
        end

        it 'should save with a name and location' do
            area = Area.new(name: 'my name', location: locations(:disneyland))
            expect(area.save).to be_truthy
        end
    end

    context 'with a newly created Area' do
        fixtures :locations

        before(:each) do
            @area = Area.create!(name: 'my name', location: locations(:disneyland))
        end

        it 'should have an auto-generated slug' do
            expect(@area.slug).to eq('my-name')
        end

        it 'should update the slug when the name is updated' do
            @area.name = 'my new name'
            @area.save
            expect(@area.slug).to eq('my-new-name')
        end

        it 'should use the slug as param' do
            expect(@area.to_param).to eq('my-name')
        end
    end
end
