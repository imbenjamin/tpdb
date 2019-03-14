class Area < ApplicationRecord
    include Rails.application.routes.url_helpers
    include Sluggi::Slugged

    def to_param
        slug
    end

    def slug_candidates
        [
            name,
                -> { "#{name}-#{Cat.count}" }
        ]
    end
    
    def slug_value_changed?
        name_changed?
    end

    def uri
        api_area_path(id)
    end

    def web_uri
        area_path(slug: slug)
    end

    validates :name,    presence: true
    validates :slug,    presence: true

    has_one_attached :logo

    belongs_to :location
    has_many :attractions
end
