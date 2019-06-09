require "active_support/core_ext/class/attribute"
require "queryko/naming"
require "queryko/able"
require "queryko/filterer"
require "queryko/filter_classes"

module Queryko
  class Base
    attr_reader :countable_resource
    include Queryko::FilterClasses
    include Queryko::Naming
    include Queryko::Able
    include Queryko::Filterer

    attr_reader :params
    # include AfterAttributes
    def self.inherited(subclass)
      # It should not be executed when using anonymous class
      subclass.table_name inferred_from_class_name(subclass) if subclass.name
    end


    def initialize(params = {}, rel)
      @relation = @original_relation = rel || inferred_model.all
      @params = default_params.merge(params)
    end

    def default_params
      @default_params ||= build_default_params
    end

    def build_default_params
      {
        page: 1,
        limit: 50,
        paginate: true
      }
    end

    def self.call(params = {}, rel)
      new(params, rel).call
    end

    def call
      perform
      return relation
    end

    def perform
      return if @performed

      @performed = true
      filter
      filter_by_filters
      @countable_resource = relation
    end


    def self.total_count(params = {}, rel)
      new(params, rel).total_count
    end

    def total_count
      perform
      countable_resource.count
    end

    def self.count(params = {}, rel)
      new(params, rel).count
    end

    def count
      call.to_a.count
    end

    private

    attr_accessor :relation

    def config
      @config ||= {
      }
    end

    def filter
      # overridable method
    end
  end
end
