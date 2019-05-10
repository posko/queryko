module Queryko
  module Searchables
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_searchables(*args)
        args.each do |arg|
          feature arg.to_sym, :search, as: arg.to_sym
        end
      end
    end
  end
end
