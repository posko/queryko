module Queryko
  module Naming
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class_attribute :defined_table_name, default: nil, instance_writer: false
        class_attribute :defined_model_class, default: nil, instance_writer: false

        def table_name
          self.class.table_name
        end

        def model_class
          self.class.model_class
        end
      end
    end

    module ClassMethods
      def table_name(name = nil)
        if name
          self.defined_table_name = name.to_s
        elsif self.defined_table_name.nil?
          self.defined_table_name = inferred_from_class_name(self)
        end

        return self.defined_table_name
      end

      def model_class(name = nil)
        if name
          self.defined_model_class = name.to_s.constantize
        elsif self.defined_model_class.nil?
          self.defined_model_class = inferred_model(self)
        end

        return self.defined_model_class
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
