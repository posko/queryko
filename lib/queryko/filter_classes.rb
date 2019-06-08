require "queryko/filters/base"
require "queryko/filters/after"
require "queryko/filters/before"
require "queryko/filters/min"
require "queryko/filters/max"
require "queryko/filters/search"

module Queryko
  module FilterClasses
      def self.included(base)
        base.extend(ClassMethods)
        base.class_eval do
          class_attribute :filters, default: {}
          load_defaults
        end
      end

      module ClassMethods
        def load_defaults
          self.filters = {
            after: Queryko::Filters::After,
            before: Queryko::Filters::Before,
            min: Queryko::Filters::Min,
            max: Queryko::Filters::Max,
            search: Queryko::Filters::Search
          }
        end
      end
  end
end
