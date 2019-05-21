module Ynab
  class Allocation < ApplicationRecord
    belongs_to :user
  end
end