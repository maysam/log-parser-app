# frozen_string_literal: true

require 'sequel'

# associates the number of counts with each page
class Countable < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers
  plugin :json_serializer

  def validate
    super
    validates_presence [:page]
  end
end
Countable.unrestrict_primary_key
