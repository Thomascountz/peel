require 'sqlite3'

module Peel
  class Repository
    def initialize(database: SQLite3::Database)
      database_file = Peel.configuration.database_file
      @database = database.new(database_file)
    end

    def execute(query, bind_vars=[], *args, &block)
      @database.execute(query, bind_vars, *args, &block)
    end
  end
end