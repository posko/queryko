[![Gem Version](https://badge.fury.io/rb/queryko.svg)](https://badge.fury.io/rb/queryko)
# Queryko
This gem provides additional functionality on your query objects. It will filter and paginate your query by supplying an option

## Installation
For now, it only works with kaminari
```ruby
gem 'kaminari'
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

  def initialize params={}, relation = Product.all
    super(params, relation)
  end
end
```

### Using your query object
Filter your query by appending `_min` or `_max` on your defined attributes. You can also filter searc3h by attribute.
As long as you defined it in your query object definition.
``` ruby
products = ProductsQuery.new(price_min: 100, price_max: 150, name: 'Milk').call
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
