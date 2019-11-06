require "active_support/core_ext/class/attribute"
require "queryko/naming"
require "queryko/able"
require "queryko/filterer"
require "queryko/filter_classes"
# require "byebug"

module Queryko

  class Base
    attr_reader :countable_resource
    include Queryko::FilterClasses
    include Queryko::Naming
    include Queryko::Able
    include Queryko::Filterer

    attr_reader :params


    def initialize(params = {}, rel=nil)
      @relation = @original_relation = rel || self.class.model_class.all
      @params = self.default_params.merge(params)
    end

    def self.call(params = {}, rel = nil)
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


    def self.total_count(params = {}, rel = nil)
      new(params, rel).total_count
    end

    def total_count
      perform
      countable_resource.count
    end

    def self.count(params = {}, rel = nil)
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
