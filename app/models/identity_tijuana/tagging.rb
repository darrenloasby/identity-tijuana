module IdentityTijuana
  class Tagging < ApplicationRecord
    include ReadWrite
    self.table_name = 'taggings'
    def self.name
      "Tagging"
    end
    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
