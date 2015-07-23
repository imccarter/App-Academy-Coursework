require_relative '03_associatable'
require 'byebug'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)

    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      method = self.class.assoc_options.values.first.foreign_key.to_s
      # debugger
      value_we_want_to_escape_into_query = self.send(method)
      self.class.parse_all(DBConnection.execute(<<-SQL, value_we_want_to_escape_into_query)
        SELECT
          #{source_options.table_name}.*
        FROM
          #{through_options.table_name}
        JOIN
          #{source_options.table_name} ON #{source_options.table_name}.#{source_options.primary_key} = #{through_options.table_name}.#{source_options.foreign_key}
        WHERE
          #{through_options.table_name}.#{through_options.primary_key} = ?
        LIMIT
          1
        SQL
        )
    end


  end
end
