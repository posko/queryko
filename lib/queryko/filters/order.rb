require "queryko/filters/base"

class Queryko::Filters::Order < Queryko::Filters::Base

  def perform(collection, token, query_object = nil)
    collection.order("#{table_name}.#{column_name} #{filter_input(token)}", )
  end

  def filter_input(token)
    return 'DESC' if token.to_s.downcase == 'desc'
    return 'ASC'
  end

  def param_key_format
    "order_by_#{column_name}"
  end
end