module Queryko
  module RangeAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_range_attributes(*args)
        args.each do |arg|
          feature arg.to_sym, :min
          feature arg.to_sym, :max
        end
      end
    end
  end
end
