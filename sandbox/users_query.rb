class UsersQuery
  feature [:created_at, :updated_at, :deleted_at], filters: [
    after: { as: -> (name) { "#{name}_after"}},
    :before, :min, :max, search: { cond: :like, token_format: -> (token) { token.upcase }, as: :search_keyword}],
    table_name: :users

  feature :created_at, :search, cond: :like, token_format: '%token%'
  feature :created_at, :min
  feature :created_at, :max

  feature :created_at, filters: [:after, :before, :min, :max, search: { cond: :like, token_format: '%token%', as: :q}]

  feature :search, search: [{ column_name: :first_name, cond: :eq, token_format: 'token%'}]

    # users.last_name ? ? OR users.name OR profiles.created_at

  # def add_feature(name, options)
  #   features[name] = Queryko::Feature.new(name, options, self)
  # end
end
