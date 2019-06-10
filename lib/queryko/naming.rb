module Queryko
  module Naming
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class_attribute :defined_table_name, default: :table, instance_writer: false
        class_attribute :defined_model_class, default: :table, instance_writer: false
        def table_name
          self.defined_table_name
        end
      end
    end

    module ClassMethods
      def table_name(name = nil)
        return self.defined_table_name unless name
        self.defined_table_name = name.to_s
      end

      def model_class(name = nil)
        return self.defined_model_class unless name
        self.defined_model_class = name.to_s.constantize
      end

      def inferred_from_class_name(klass)
        # class names should be in plural form by default. No need to tableize
        klass.name.chomp('Query').split('::').last.underscore
      end

      def inferred_model(klass)
        inferred_from_class_name(klass).singularize.camelize.constantize
      end
    end
  end
end
