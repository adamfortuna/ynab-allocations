module Ynab
  class Category < ApplicationRecord
    belongs_to :category_group
    has_many :spendings, dependent: :destroy

    def recent_spending
      spendings.first
    end
  end
end
