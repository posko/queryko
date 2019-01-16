module Queryko
  module Naming
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class_attribute :defined_table_name, default: :table, instance_writer: false
        set_table_name

        def table_name
          self.defined_table_name
        end
      end
    end

    module ClassMethods
      def set_table_name
        self.defined_table_name = self.inferered_from_class_name
      end

      def table_name(name = nil)
        return self.defined_table_name unless name
        self.defined_table_name = name.to_s
      end

      def inferered_from_class_name
        # class names should be in plural form by default. No need to tableize
        self.class.name.chomp('Query').split('::').last.underscore
      end
    end
  end
end
