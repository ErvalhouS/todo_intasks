# frozen_string_literal: true

# An abstract model to allow common behavior to be inherited
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Implements soft-delete system-wise
  include Discard::Model

  # Defaults scope to only non-discarded records
  default_scope -> { kept }

  # Avoids inconsistencies on `_count` fields and discards instead of destroying
  # when calling `destroy` on a record
  def destroy
    discard
    self.class.reflect_on_all_associations(:belongs_to).each do |association|
      next unless association.try(:counter_cache_column).present?

      association.klass
                 .decrement_counter(counter_column_name,
                                    send(association.foreign_key))
    end
  end

  # Avoids inconsistencies on `_count` fields when undiscarding a record
  def undiscard
    super
    self.class.reflect_on_all_associations(:belongs_to).each do |association|
      next unless association.try(:counter_cache_column).present?

      association.klass
                 .increment_counter(counter_column_name,
                                    send(association.foreign_key))
    end
  end

  # Wrapper to the `_count` column name on related models
  def counter_column_name
    (self.class.name.underscore.pluralize + '_count').to_sym
  end
end