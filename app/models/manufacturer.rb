class Manufacturer < ApplicationRecord
    include Rails.application.routes.url_helpers
    include Sluggi::Slugged

    def to_param
        slug
    end

    def slug_candidates
        [
            name,
                -> { "#{name}-#{Manufacturer.count}" }
        ]
    end
    
    def slug_value_changed?
        name_changed?
    end

    def uri
        api_manufacturer_path(id)
    end

    def web_uri
        manufacturer_path(slug: slug)
    end

    validates :name,    presence: true
    validates :slug,    presence: true

    has_many :attractions

    # JSON API response
    def as_json(options={})
        super(  root: true,
                only: [:id, :slug, :website, :description],
                methods: [:uri, :web_uri],
                include: {
                        :attractions => {   :only => [:id, :name, :slug],
                                            :methods => [:uri, :web_uri],
                                            :include => {:location => { :only => [:id, :name, :slug],
                                                                        :methods => [:uri, :web_uri]}}}
                }
        )
    end
end
