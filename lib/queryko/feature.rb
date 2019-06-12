class Queryko::Feature
  attr_reader :name, :filter_names, :query_object
  def initialize(name, query_object)
    @name = name
    @query_object = query_object
    @filter_names = {}
  end

  def add_filter(filter_name, options = {})
    self.filter_names[filter_name] = create_filter(filter_name, options)
  end

  def create_filter(filter_name, options = {})
    if filter_class = filter_class_for(filter_name)
      result = filter_class.new(options, self)
    else
      raise "Filter class for #{filter_name} not found"
    end
    result
  end

  def filter_class_for(filter_name)
    filter_class = self.query_object.filters.fetch(filter_name.to_sym)
    return filter_class.constantize if filter_class.class == String
    return filter_class
  end
end
