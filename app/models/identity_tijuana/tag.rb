module IdentityTijuana
  class Tag < ApplicationRecord
    include ReadWrite
    def self.name
      "Tag"
    end
    self.table_name = 'tags'
    has_many :taggings
    has_many :users, through: :taggings
  end
end
