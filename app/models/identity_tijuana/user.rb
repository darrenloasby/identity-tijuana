module IdentityTijuana
  class User < ApplicationRecord
    include ReadOnly
    def self.name
      "User"
    end
    self.table_name = 'users'
#     has_many :taggings, as: :taggable
#     has_many :tags, through: :taggings
    acts_as_taggable
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
      member_hash[:tags] = tags.where('(name LIKE "%sync" OR name LIKE "%sync%") AND listcut = false').map{|t| t.name }
      
      Lead.delay.upsert_lead(member_hash)
    end
  end
end

class User < IdentityTijuana::User
end

