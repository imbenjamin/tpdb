class Attraction < ApplicationRecord
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
        api_attraction_path(id)
    end

    def web_uri
        attraction_path(slug: slug)
    end

    validates :name,    presence: true,
                        length: { minimum: 5 }
    validates :slug,    presence: true

    has_one_attached :logo

    belongs_to :area, optional: true
    belongs_to :location
    belongs_to :attraction_type
    belongs_to :manufacturer

    attribute_method_suffix '_in_mph', '_in_ft'

    # JSON API response
    def as_json(options={})
        super(  root: true,
                only: [:id, :slug, :name, :description, :opening_date, :closing_date, :top_speed, :capacity, :inversions, :length, :height],
                methods: [],
                include: {
                            :attraction_type => {   :only => [:id, :name, :description],
                                                    :methods => [:uri, :web_uri]},
                            :manufacturer => {  :only => [:id, :name, :slug],
                                                :methods => [:uri, :web_uri]},
                            :area => {  :only => [:id, :name, :slug],
                                        :methods => [:uri, :web_uri]},
                            :location => {  :only => [:id, :name, :slug],
                                            :methods => [:uri, :web_uri]}
                        }
            )
    end

    private
        def attribute_in_mph(attr)
            return self[attr] * 2.23694
        end

        def attribute_in_ft(attr)
            return self[attr] * 3.28084
        end
end
