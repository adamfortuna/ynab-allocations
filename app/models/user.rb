class User < ApplicationRecord
  has_many :allocations, dependent: :destroy, class_name: "Ynab::Allocation"
  has_many :budgets, dependent: :destroy, class_name: "Ynab::Budget"
  has_many :spendings, dependent: :destroy, class_name: "Ynab::Spending"

  def category_groups
    @category_groups ||= budget.category_groups
  end

  def budget
    @budget ||= budgets.first
  end
end
