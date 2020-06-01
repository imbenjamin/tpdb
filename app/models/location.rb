class Location < ApplicationRecord
    include Rails.application.routes.url_helpers
    include Sluggi::Slugged

    def to_param
        slug
    end

    def slug_alt
        "#{name}-#{Location.count}"
    end

    def slug_candidates
        [name, slug_alt]
    end
    
    def slug_value_changed?
        name_changed?
    end

    def uri
        api_location_path(id)
    end

    def web_uri
        location_path(slug: slug)
    end

    def logo_uri
        if logo.attached?
            rails_blob_path(logo, only_path: true)
        end
    end

    validates :name,    presence: true,
                        length: { minimum: 5 }
    validates :slug,     presence: true
    
    has_many :areas, dependent: :destroy
    has_many :attractions, dependent: :nullify
    has_one_attached :logo

    has_many :children, class_name: "Location", foreign_key: "parent_id"
    belongs_to :parent, class_name: "Location", optional: true

    # Geocode validation
    geocoded_by :address do |obj, results|
        if geo = results.first
            obj.latitude = geo.latitude
            obj.longitude = geo.longitude
            obj.city = geo.city
            obj.state = geo.state
            obj.country = geo.country
            if defined? geo.place_id
                obj.google_place_id = geo.place_id
            end
        end
    end
    after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
    # after_validation :reverse_geocode, unless: ->(obj) { obj.address.present? }, if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }

    # JSON API response
    def as_json(options={})
        super(  root: true,
                only: [:id, :parent_id, :name],
                methods: [:uri, :web_uri, :logo_uri],
                include: {  :children => {      :only => [:id, :name],
                                                :methods => [:uri, :web_uri]},
                            :areas => {         :only => [:id, :name],
                                                :methods => [:uri, :web_uri]},
                            :attractions => {   :only => [:id, :name],
                                                :methods => [:uri, :web_uri],
                                                :include => {:attraction_type => {  :only => [:id, :name],
                                                                                    :methods => [:uri, :web_uri]
                                                                                }
                                                            }
                                            }
                        }
            )
    end
end
