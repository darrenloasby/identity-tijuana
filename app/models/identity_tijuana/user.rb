module IdentityTijuana
  class User < ApplicationRecord
    include ReadOnly
    self.table_name = 'users'
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
    belongs_to :postcode, optional: true

    def import
      member_hash = {
        firstname: first_name,
        lastname: last_name,
        email: email,
        address1: street_address,
        city: suburb,
        zipcode: postcode.try(:number),
        doNotContact: !is_member
      }
      c = ISO3166::Country.new(country_iso || 'AU')
      member_hash[:country] = c.name if country_iso or postcode
      member_hash[:state] = c.states[postcode.state]["name"] if postcode
      member_hash[:phone] = home_number if home_number.present?
      member_hash[:mobile] = mobile_number if mobile_number.present?
      member_hash[:mobile] = tags.join(',')
      
      Lead.delay.upsert_lead(member_hash)
    end
  end
end
class User < IdentityTijuana::User
end
