module DataMapper
  class Collection
    include Searchable::SearchMethods

    def searchable_fields
      model.searchable_fields
    end
  end
end