module DataMapper
  module Associations
    module OneToMany
      class Proxy
        include Searchable::SearchMethods

        def searchable_fields
          if @relationship.respond_to?(:remote_relationship, true)
            @relationship.send(:remote_relationship).parent_model.searchable_fields
          else
            @relationship.child_model.searchable_fields
          end
        end

        def query
          if @relationship.respond_to?(:remote_relationship, true)
            @relationship.send(:remote_relationship).query
          else
            @relationship.query
          end
        end
      end
    end
  end
end