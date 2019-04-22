require "active_support/core_ext/class/attribute"
require "queryko/range_attributes"
require "queryko/searchables"
require "queryko/after_attributes"
require "queryko/naming"

module Queryko
  class QueryObject
    attr_reader :countable_resource
    include Queryko::Naming
    include Queryko::RangeAttributes
    include Queryko::Searchables
    # include AfterAttributes

    def self.inherited(subclass)
      # It should not be executed when using anonymous class
      subclass.table_name inferred_from_class_name(subclass) if subclass.name
    end

    def initialize(params = {}, rel)
      @relation = @original_relation = rel
      @params = params
    end

    def call
      perform
      self.relation = paginate if config[:paginate]
      return relation
    end

    def perform
      return if @performed

      @performed = true
      pre_filter
      filter
      filter_by_range_attributes
      filter_by_searchables
      @countable_resource = relation
    end


    def total_count
      perform
      countable_resource.count
    end

    def count
      call.to_a.count
    end

    private

    attr_reader :params, :relation
    attr_writer :relation

    def config
      @config ||= {
        paginate: true,
        since_id: true,
        ids: true
      }
    end

    def pre_filter
      self.relation = by_ids if config[:ids] && params[:ids]
      self.relation = since_id if config[:since_id] && params[:since_id]
    end

    def filter
    end

    def paginate
      if defined?(WillPaginate)
        relation.paginate(page: page, per_page: limit)
      elsif defined?(Kaminari)
        relation.page(page).per(limit)
      else
        raise 'Only kaminari and wil_paginate are supported'
      end
    end

    def page
      params[:page] || 1
    end

    def limit
      @limit ||= get_limit
    end

    def get_limit
       lim = (params[:limit] || default_limit).to_i
       if lower_limit > lim
         lower_limit
       elsif lim > upper_limit
         upper_limit
       else
         lim
       end
    end

    def upper_limit
      100
    end

    def default_limit
      50
    end

    def lower_limit
      10
    end

    def by_ids
      relation.where(id: params[:ids])
    end

    def since_id
      relation.where("\"#{defined_table_name}\".\"id\" > ?", params[:since_id])
    end

  end
end
