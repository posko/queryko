module Queryko
  module Able
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class_attribute :defined_filters, default: {}, instance_writer: false
        class_attribute :features, default: {}, instance_writer: false
        class_attribute :fields, default: {}, instance_writer: false
        class_attribute :default_params, default: {}
      end
    end

    module ClassMethods
      def feature(feature_name, filter, options = {})
        # returns the feature if it exists
        feat = self.features[feature_name.to_sym] ||= Queryko::Feature.new feature_name, self
        self.defined_filters[filter] ||= Array.new

        # creates a filter
        filt = feat.add_filter filter, options
        self.defined_filters[filter].push(filt)

        # appends new field
        self.fields[filt.field.to_sym] ||= Array.new
        self.fields[filt.field.to_sym].push(filt)
      end

      def default_param(sym, value)
        self.default_params[sym] = value
      end

      def inherited(subclass)
        subclass.defined_filters = self.defined_filters.clone || {}
        subclass.features = self.features.clone || {}
        subclass.fields = self.fields.clone || {}
        subclass.default_params = self.default_params.clone || {}
      end
    end
  end
end
