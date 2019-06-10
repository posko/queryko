module Queryko
  module Filterer
    def filter_by_filters
      fields.each do |field, filter|
        if field == 'limit' || field == 'page'
          paginate(filter, )
        end
        self.relation = filter.first.call(relation, params[field], self) if params[field]
      end
    end

    def paginate(filter)
      unless @paginated
      end
      @paginated ||= true
    end
  end
end
