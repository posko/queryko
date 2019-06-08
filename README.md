[![Gem Version](https://badge.fury.io/rb/queryko.svg)](https://badge.fury.io/rb/queryko)
# Queryko
This gem provides additional functionality on your query objects. It will filter and paginate your query by supplying arguments directly from controller params

## Installation

```ruby
# Pagination
gem 'kaminari'
#or
gem 'will_paginate'

# Query Object
gem 'queryko'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install queryko

## Usage

### Create a query object

``` ruby
class ProductsQuery < Queryko::QueryObject
  feature :created_at, :min
  feature :created_at, :max
  feature :price, :min
  feature :price, :max
  feature :name, :search, as: :name
  feature :vendor, :search, as: :vendor
end
```

### Using your query object
Filter your query by appending `_min` or `_max` on your defined attributes. You can also filter results by attribute with your defined feature.

``` ruby
# Collection
products = ProductsQuery.new(price_min: 100, price_max: 150, name: 'Milk').call
products = ProductsQuery.new(since_id: 26).call

# Count - Counts items on current page. Default page is 1
products = ProductsQuery.new(created_at_min: 'Jan 1, 2019').count
products = ProductsQuery.new(name: 'Bag').count

# Total Count - Counts all items matching defined conditions
products = ProductsQuery.new(created_at_min: 'Jan 1, 2019').total_count
products = ProductsQuery.new(name: 'Bag').total_count
```


#### Object Methods
- **count** - Returns the filtered count including pagination filter or the size of return object.
- **total_count** - Returns the overall count of the filtered total records.

Example:

```
Products.count        # 21 rows
query = ProductsQuery.new(page: 5, limit: 5)

query.count           # 1
query.total_count     # 21
```
### Pagination
Override these methods to customize pagination limits

``` ruby
...

def upper_limit
  20 # default is 100
end

def lower_limit
  5 # default is 10
end

def default_limit
  10 # default is 50
end

...
```

### Custom Filters
Create a custom filter class using `Queryko::Filters::Base`

``` ruby
class CustomFilters::CoolSearch < Queryko::Filters::Base

  # Optional.
  # Some `options` keys are reserved for basic functionality
  # Use `options` to get data from feature definition
  def intialize(options = {}, feature)
    super options, feature
  end

  # Required. This method is called by query object. Always return the result of
  # the collection
  def perform(collection, token)
    collection.where("#{table_name}.#{column_name} < ?", "Cool-#{token}")
  end
end
```

Then add the filter class to your Queryko::Base object
``` ruby
class QueryObject < Queryko::Base
  filter_class :cool_search, CustomFilters::CoolSearch
  # or
  filter_class :cool_search, "CustomFilters::CoolSearch"


  feature :name, :cool_search
  # the :name will be scoped using params[:name_cool_search]
end
```

### Other available options
| Option   | description                  |
|:---------|:-----------------------------|
| since_id | retrieves records after `id` |
| page     | page to retrieve             |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/neume/queryko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
