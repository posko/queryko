require "queryko/filters/base"

class Queryko::Filters::Batch < Queryko::Filters::Base
  def intialize(options = {}, feature)
    super options, feature
  end

  def perform(collection, token)
    collection.where("#{table_name}.#{column_name} IN (?)", token.split(','))
  end

  def param_key_format
    "by_#{column_name.pluralize}"
  end
end
