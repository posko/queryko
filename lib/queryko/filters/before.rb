require "queryko/filters/base"

class Queryko::Filters::Before < Queryko::Filters::Base
  def intialize(options = {}, feature)
    super options, feature
  end

  def perform(collection, token, query_object)
    collection.where("#{table_name}.#{column_name} < ?", token)
  end
end
