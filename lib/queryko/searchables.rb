module Queryko
  module Searchables
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_searchables(*args)
        suggestion = []
        args.each do |arg|
          feature arg.to_sym, :search, as: arg.to_sym
          suggestion << "feature :#{arg}, :search, as: #{arg}"
        end
        warn "[DEPRECATION] `add_searchables` is deprecated. Please use `feature` instead.\nExample:\n#{suggestion.join("\n")}"
      end
    end
  end
end
