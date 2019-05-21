module Ynab
  class CategoryGroup < ApplicationRecord
    belongs_to :budget
    has_many :categories, dependent: :destroy
  end
end