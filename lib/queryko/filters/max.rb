require "queryko/filters/base"

class Queryko::Filters::Max < Queryko::Filters::Base
  def perform(collection, token, query_object = nil)
    collection.where("#{table_name}.#{column_name} <= ?", token)
  end
end
