require "bundler/setup"

require 'active_record'
require "queryko"
require "fixtures/app/models/product"
require "fixtures/app/models/account"
require 'active_support/inflector/methods'
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
    Account.delete_all
  end
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
migration_files_path = File.expand_path('../fixtures/app/migrations', __FILE__)

if ActiveRecord.gem_version >= Gem::Version.new('5.2.2')
  ActiveRecord::MigrationContext.new(migration_files_path).migrate
else
  ActiveRecord::Migrator.migrate(migration_files_path)
end
