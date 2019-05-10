module Queryko
  module AfterAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_after_attributes(*args)
        suggestion = []
        args.each do |arg|
          feature arg.to_sym, :after, as: "after_#{arg}"
          suggestion << "feature :#{arg}, :after, as: 'after_#{arg}'"

        end
        warn "[DEPRECATION] `add_after_attributes` is deprecated. Please use `feature` instead.\nExample:\n#{suggestion.join("\n")}"
      end
    end
  end
end
