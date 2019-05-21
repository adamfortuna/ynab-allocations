module Ynab
  class Spending < ApplicationRecord
    belongs_to :category
    belongs_to :user

    def for allocate_from
      if allocate_from == "budgeted"
        budgeted
      else
        activity
      end
    end
  end
end
