# frozen_string_literal: true

# User model. Abstracts login and authorization into the system.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,  :recoverable, :registerable,
         :rememberable, :validatable, :confirmable, :lockable, :trackable
  has_many :tasks
  has_many :categories
  accepts_nested_attributes_for :tasks, :categories

  # Is this user an admin?
  def admin?
    role == 'admin'
  end
end
