Rails.application.routes.draw do
  namespace :ynab do
    resources :budgets
    resources :allocations
  end
end
