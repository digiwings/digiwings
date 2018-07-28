class Airfield < ApplicationRecord
  include PgSearch
  pg_search_scope :search_full_text, against: {
    name:   'A',
    city: 'B'
  }, :using => [:tsearch, :trigram]


  acts_as_mappable :default_units => :nms,
    :default_formula => :sphere,
    :distance_field_name => :distance,
    :lat_column_name => :lat,
    :lng_column_name => :lon
end
