module Queryko
  module Filters
    class Base
      attr_reader :table_name, :column_name, :feature, :as, :field

      def initialize(options = {}, feature)
        @feature = feature
        @table_name = options.fetch(:table_name) { @feature.query_object.defined_table_name }
        @column_name = options.fetch(:column_name) { @feature.name }
        @as = options[:as]
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
