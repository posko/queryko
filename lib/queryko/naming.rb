module Queryko
  module Naming
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class_attribute :defined_table_name, default: :table, instance_writer: false
        table_name inferred_from_class_name(self)
        def table_name
          self.defined_table_name
        end
      end
    end

    module ClassMethods
      # def set_table_name
      #   self.defined_table_name = self.
      # end


      def table_name(name = nil)
        return self.defined_table_name unless name
        self.defined_table_name = name.to_s
      end

      def inferred_from_class_name(klass)
        # class names should be in plural form by default. No need to tableize
        klass.name.chomp('Query').split('::').last.underscore
      end

      def inferred_model
        inferred_from_class_name.last.singularize.constantize
      end
    end
  end
end
