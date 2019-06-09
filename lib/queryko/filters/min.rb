require "queryko/filters/base"

class Queryko::Filters::Min < Queryko::Filters::Base
  def perform(collection, token, query_object = nil)
    collection.where("#{table_name}.#{column_name} >= ?", token)
  end

  def build_field_from_column
    "#{column_name}_min"
  end
end
