module Queryko
  module Filters
    class Base
      attr_reader :table_name, :column_name, :feature, :as, :field, :query_object

      def initialize(options = {}, feature)
        @feature = feature
        @table_name = options[:table_name]
        @column_name = options.fetch(:column_name) { @feature.name }
        @as = options[:as]
      end

      def call(collection, token, query_object)
        @query_object = query_object
        @table_name ||= query_object.class.table_name

        perform(collection, token, query_object)
      end

      def field
        @field ||= as || build_param_key
      end

      def param_key_format
        nil
      end

      private

      def build_param_key
        param_key_format || default_param_key_format
      end

      def default_param_key_format
        "#{column_name}_#{parameterized_name}"
      end

      def parameterized_name
        self.class.name.split('::').last.underscore
      end
    end
  end
end
