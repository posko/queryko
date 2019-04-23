module Queryko
  module Filters
    class Base
      attr_reader :table_name, :column_name, :feature, :as

      def initialize(options = {}, feature)
        @table_name = options.fetch(:table_name)
        @column_name = options.fetch(:column_name)
        @feature = feature
        @as = options[:as]
      end
    end
  end
end
