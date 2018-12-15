module IdentityTijuana
  class Tag < ApplicationRecord
    include ReadWrite
    self.table_name = 'tags'
    has_many :taggings, :as => :taggable
    has_many :users, through: :taggings, source: :taggable, source_type: User
  end
end
