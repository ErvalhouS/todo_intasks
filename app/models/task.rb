# frozen_string_literal: true

# Task model. Something a user is meaning to do at some point.
class Task < ApplicationRecord
  belongs_to :user, counter_cache: true, touch: true
  belongs_to :category, optional: true, counter_cache: true, touch: true
  validates :title, length: { minimum: 5 }
  validate :non_expired_creation, if: :due_at_changed?

  # Is task past due?
  def expired?
    due_at.present? && due_at < Time.now
  end

  # Is task completed?
  def completed
    completed_at.present?
  end

  # Sets completed_at to time now if +complete+ is 'true'
  def completed=(complete)
    self.completed_at = (complete == 'true') ? Time.now : nil
  end

  private

  # Validates if task is being set as already dued
  def non_expired_creation
    errors.add(:due_at, I18n.t('task.expired_creation')) if expired?
  end
end
