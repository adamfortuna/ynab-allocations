module Ynab
  class BudgetsController < ApplicationController
    layout 'ynab'

    def index
      @budgets = current_user.budgets
    end

    def show

    end
  end
end
