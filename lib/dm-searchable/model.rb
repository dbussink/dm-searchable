module DataMapper
  module Model
    attr_reader :searchable_fields
    include Searchable::SearchMethods
  end
end