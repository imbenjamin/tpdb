require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
    context 'when creating a new Manufacturer' do
        it 'should not save without a name' do
            manufacturer = Manufacturer.new
            expect(manufacturer.save).to be_falsy
        end

        it 'should save with only a name' do
            manufacturer = Manufacturer.new(name: 'my name')
            expect(manufacturer.save).to be_truthy
        end
    end

    context 'with a newly created Manufacturer' do
        before(:each) do
            @manufacturer = Manufacturer.create!(name: 'my name')
        end

        it 'should have an auto-generated slug' do
            expect(@manufacturer.slug).to eq('my-name')
        end

        it 'should update the slug when the name is updated' do
            @manufacturer.name = 'my new name'
            @manufacturer.save
            expect(@manufacturer.slug).to eq('my-new-name')
        end

        it 'should use the slug as param' do
            expect(@manufacturer.to_param).to eq('my-name')
        end
    end
end
