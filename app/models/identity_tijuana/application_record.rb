module IdentityTijuana
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    def self.name
      super.split('::').last
    end
  end
end
