module Queryko
  module Filters
    class Base
      attr_reader :table_name, :column_name, :feature, :as, :field, :query_object

      def initialize(options = {}, feature)
        @feature = feature
        @table_name = options.fetch(:table_name) { @feature.query_object.defined_table_name }
        @column_name = options.fetch(:column_name) { @feature.name }
        @as = options[:as]
      end

      def call(collection, token, query_object)
        @query_object = query_object
        @table_name ||= query_object.class.table_name

        perform(collection, token, query_object)
      end

      def field
        @field ||= as || build_field_from_column
      end

      def build_field_from_column
        "#{column_name}_#{self.class.name.split('::').last.underscore}"
      end
    end
  end
end
