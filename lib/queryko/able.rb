module Queryko
  module Able
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      class_attribute :filters, default: {}, instance_writer: false
      class_attribute :features, default: {}, instance_writer: false
      class_attribute :fields, default: {}, instance_writer: false
      self.filters = {}
      self.features = {}
      self.fields = {}

      private
    end
  end

  module ClassMethods
    def feature(feature_name, filter, options = {})
      # returns the feature if it exists
      feat = self.features[feature_name.to_sym] ||= Queryko::Feature.new feature_name, self
      self.filters[filter] ||= Array.new

      # creates a filter
      filt = feat.create_filter filter, options
      self.filters[filter].push(filt)

      # appends new field
      self.fields[filt.field.to_sym] ||= Array.new
      self.fields[filt.field.to_sym].push(filt)
    end
  end
end
end
