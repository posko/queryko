require "queryko/filters/base"

class Queryko::Filters::Order < Queryko::Filters::Base
  def intialize(options = {}, feature)
    super options, feature
  end

  def perform(collection, token, params = {})
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