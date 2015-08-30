require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {}
    defaults[:foreign_key] = (name.to_s + "_id").to_sym
    defaults[:class_name] = (name.to_s.camelcase)
    defaults[:primary_key] = :id

    finalized_options = defaults.merge(options)

    @foreign_key = finalized_options[:foreign_key]
    @class_name = finalized_options[:class_name]
    @primary_key = finalized_options[:primary_key]

    finalized_options
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {}
    defaults[:foreign_key] = (self_class_name.to_s.underscore + "_id").to_sym
    defaults[:class_name] = (name.to_s.singularize.camelcase)
    defaults[:primary_key] = :id

    finalized_options = defaults.merge(options)

    @foreign_key = finalized_options[:foreign_key]
    @class_name = finalized_options[:class_name]
    @primary_key = finalized_options[:primary_key]

    finalized_options
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method(name) do
      fk = send(options.foreign_key)
      mc = options.model_class
      mc.where(id: fk).first
    end

  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self, options)

    define_method(name) do
      pk = send(options.primary_key)
      mc = options.model_class
      mc.where(options.foreign_key => pk)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
