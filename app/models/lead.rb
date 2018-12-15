
  class Lead < ApplicationRecord
      def self.upsert_lead(attrs)
        Mautic::Connection.last.contacts.new(attrs).save
      end
  end
