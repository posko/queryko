require "queryko/filters/base"

class Queryko::Filters::Paginate < Queryko::Filters::Base
  attr_reader :upper_limit, :lower_limit, :default_limit, :params

  def initialize(options = {}, feature)
    puts '-' * 100
    puts options
    @upper_limit = options.fetch(:upper) { 100 }
    @lower_limit = options.fetch(:lower) { 10 }

    super(options, feature)
  end

  def perform(collection, paginate, query_object)
    if paginate
      @params = query_object.params
      puts "#{query_object.params}: #{page} : #{limit}"

      if defined?(WillPaginate)
        collection.paginate(page: page, per_page: limit)
      elsif defined?(Kaminari)
        collection.page(page).per(limit)
      else
        raise 'Only kaminari and wil_paginate are supported'
      end
    end
  end

  def page
    params[:page] || 1
  end

  def limit
    get_limit
  end

  def get_limit
     lim = params[:limit].to_i
     if lower_limit > lim
       lower_limit
     elsif lim > upper_limit
       upper_limit
     else
       lim
     end
  end

  def param_key_format
    "paginate"
  end
end
