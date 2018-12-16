module IdentityTijuana
  class Postcode < ApplicationRecord
    include ReadWrite
    self.table_name = 'postcodes'
    has_many :users
    def self.name
      "Postcode"
    end
  end
end
