module IdentityTijuana
  class Postcode < ApplicationRecord
    def self.name
      "Postcode"
    end
    include ReadWrite
    self.table_name = 'postcodes'
    has_many :users
  end
end
