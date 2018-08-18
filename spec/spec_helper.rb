require "bundler/setup"

require 'active_record'
require "queryko"
require "fixtures/app/models/product"
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.before(:each) do
    Product.delete_all
  end
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Migrator.migrate(File.expand_path('../fixtures/app/migrations', __FILE__))
