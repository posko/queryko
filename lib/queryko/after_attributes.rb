module Queryko
  module AfterAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_after_attributes(*args)
        args.each do |arg|
          feature arg.to_sym, :after, as: "after_#{arg}"
        end
      end
    end
  end
end
