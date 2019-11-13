require "queryko/filters/base"

class Queryko::Filters::Batch < Queryko::Filters::Base
  def perform(collection, token, query_object = nil)
    collection.where("#{table_name}.#{column_name} IN (?)", token.split(','))

    # collection.where(
    #   table_name => {
    #     column_name => token.split('')
    #   }
    # )
  end

  def param_key_format
    "by_#{column_name.pluralize}"
  end
end
