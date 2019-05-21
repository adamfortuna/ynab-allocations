module Ynab
  class Budget < ApplicationRecord
    belongs_to :user
    has_many :category_groups, dependent: :destroy
  end
end