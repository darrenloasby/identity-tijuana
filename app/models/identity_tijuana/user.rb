module IdentityTijuana
  class User < ApplicationRecord
    include ReadOnly
    self.table_name = 'users'
    has_many :taggings
    has_many :tags, through: :users
    belongs_to :postcode, optional: true

    def import
      member_hash = {
        firstname: first_name,
        lastname: last_name,
        email: email,
        address1: street_address, city: suburb, zipcode: postcode.try(:number),
        doNotContact: is_member
      }
      
#       member_hash[:state] = postcode.try(:state) if postcode.try(:state).present?
      member_hash[:phone] = home_number if home_number.present?
      member_hash[:mobile] = mobile_number if mobile_number.present?

      Lead.delay.upsert_lead(member_hash)
    end
  end
end
class User < IdentityTijuana::User
end
