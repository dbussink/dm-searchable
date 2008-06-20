module DataMapper
  module Model
    include Searchable::SearchMethods
    def searchable_fields
      @searchable_fields
    end
  end
end