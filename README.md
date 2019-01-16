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
  add_range_attributes :created_at, :price
  add_searchables :name, :vendor

  table_name 'my_products' # optional

  def initialize params={}, relation = Product.all
    super(params, relation)
  end
end
```

### Using your query object
Filter your query by appending `_min` or `_max` on your defined attributes. You can also filter searc3h by attribute.
As long as you defined it in your query object definition.
``` ruby
# Collection
products = ProductsQuery.new(price_min: 100, price_max: 150, name: 'Milk').call
products = ProductsQuery.new(since_id: 26).call

# Count
products = ProductsQuery.new(created_at_min: 'Jan 1, 2019').count
products = ProductsQuery.new(name: 'Bag').count
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

### Other available options
| Option   | description                  |
|:---------|:-----------------------------|
| since_id | retrieves records after `id` |
| page     | page to retrieve             |
| limit    | number of records per page   |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/neume/queryko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
