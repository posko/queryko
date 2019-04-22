module Queryko
  module Filters
    class Base
      attr_reader :table_name, :column_name, :feature

      def initialize(options = {}, feature)
        @table_name = options.fetch(:table_name)
        @column_name = options.fetch(:column_name)
        @feature = feature
      end
    end
  end
end
