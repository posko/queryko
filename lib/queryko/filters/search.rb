require "queryko/filters/base"

class Queryko::Filters::Search < Queryko::Filters::Base
  attr_reader :cond, :token_format
  def initialize(options = {}, feature)
    @cond = options.fetch(:cond) { :like }
    @token_format = options[:token_format] || '%token%'
    super(options, feature)
  end

  def perform(collection, token, query_object = nil)
    query_cond, query_token = format_query_params(token)
    table_property = "#{table_name}.#{column_name}"

    collection.where("#{table_property} #{query_cond} ?", query_token)
  end

  def format_query_params(token)
    case cond.to_sym
    when :like
      ['LIKE', token_format.gsub('token', token)]
    when :eq
      ['=', token]
    when :neq
      ['IS NOT', token]
    end
  end
end
