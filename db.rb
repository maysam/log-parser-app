# frozen_string_literal: true

require 'sequel'

database_file = 'sptest.db'

DB = Sequel.sqlite(database_file)

DB.drop_table?(:countables)

DB.create_table :countables do
  String :page, null: false
  String :visitor, null: false
  Integer :count, null: false, default: 1
  primary_key %i[page visitor], name: :pageviews_pk
end
