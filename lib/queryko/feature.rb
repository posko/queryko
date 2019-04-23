class Queryko::Feature
  attr_reader :name, :filters, :query_object
  def initialize(name, query_object)
    @name = name
    @query_object = query_object
    @filters = Hash.new([])
  end

  def add_filter(filter_name, options = {})
    self.filters[filter_name] << create_filter(name, options)
  end

  private


  def create_filter(filter_name, options)
    options = default_options.merge(options)
    case filter_name
    when :after
      filters[:after] ||= Queryko::Filters::After.new(options)
    when :before
      filters[:before] ||= Queryko::Filters::Before.new(options)
    when :min
      filters[:min] ||= Queryko::Filters::Min.new(options)
    when :max
      filters[:max] ||= Queryko::Filters::Max.new(options)
    when :search
      filters[:search] ||= Queryko::Filters::Search.new(options)
    end
 end

 def default_options
   {
     class_name: self.query_object.defined_table_name,
     column_name: name
   }
 end
end
