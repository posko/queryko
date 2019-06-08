module Queryko
  module RangeAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_range_attributes(*args)
        suggestion = []
        args.each do |arg|
          feature arg.to_sym, :min
          feature arg.to_sym, :max
          suggestion << "feature :#{arg}, :min"
          suggestion << "feature :#{arg}, :max"
        end
        warn "[DEPRECATION] `add_range_attributes` is deprecated. Please use `feature` instead.\nExample:\n#{suggestion.join("\n")}"
      end
    end
  end
end
