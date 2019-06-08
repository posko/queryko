require "queryko/base"
Queryko::QueryObject = Queryko::Base

message = [
  "[DEPRECATION] Inheriting from 'Queryko::QueryObject' is depcrecated",
  "and will be removed on next major release.",
  "Inherit form 'Queryko::Base' instead."
]
warn message.join(' ')