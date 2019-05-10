class Queryko::Feature
  attr_reader :name, :filters, :query_object
  def initialize(name, query_object)
    @name = name
    @query_object = query_object
    @filters = {}
  end

  def add_filter(filter_name, options = {})
    self.filters[filter_name] << create_filter(name, options)
  end

  def create_filter(filter_name, options = {})
    case filter_name
    when :after
      result = filters[:after] ||= Queryko::Filters::After.new(options, self)
    when :before
      result = filters[:before] ||= Queryko::Filters::Before.new(options, self)
    when :min
      result = filters[:min] ||= Queryko::Filters::Min.new(options, self)
    when :max
      result = filters[:max] ||= Queryko::Filters::Max.new(options, self)
    when :search
      result = filters[:search] ||= Queryko::Filters::Search.new(options, self)
    end
    result
 end
end
