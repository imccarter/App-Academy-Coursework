require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    DBConnection.execute2(<<-SQL)
      SELECT
        t.*
      FROM
        #{table_name} t
    SQL
    .first.map(&:to_sym)
  end

  def self.finalize!

    columns.each do |col|

      define_method(col.to_s + '=') do |val|
        attributes[col] = val
      end

      define_method(col) do
        attributes[col]
      end

    end
  end

  def self.table_name=(table_name)
    instance_variable_set('@' + 'table_name', table_name)
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    parse_all(DBConnection.execute(<<-SQL)
      SELECT
        t.*
      FROM
        #{table_name} t
    SQL
    )
  end

  def self.parse_all(results)
    results.map do |hash|
      new(hash)
    end
  end

  def self.find(id)
    parse_all(DBConnection.execute(<<-SQL, id)
      SELECT
        t.*
      FROM
        #{table_name} t
      WHERE
        t.id = ?
    SQL
    ).first
  end

  def initialize(params = {})
    params.each do |attr, val|
      unless self.class.columns.include?(attr.to_sym)
        raise "unknown attribute \'#{attr}\'"
      end
      self.send(attr.to_s + '=', val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| self.send(col) }
  end

  def insert
    col_names = self.class.columns.join(", ")
    q_marks = ("?" * (self.class.columns.length)).split("").join(", ")

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{q_marks})
    SQL

    attributes[:id] = DBConnection.last_insert_row_id

  end

  def update
    col_vals = self.class.columns.map { |col| "#{col} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_vals}
      WHERE
        id = ?
    SQL

  end

  def save
    self.id.nil? ? self.insert : self.update
  end
end
