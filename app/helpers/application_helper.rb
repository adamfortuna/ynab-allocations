module ApplicationHelper
  def ynab_currency(amount, budget)
    number_to_currency(amount/1000, unit: budget.currency_symbol)
  end

  def ynab_amount(amount, budget)
    amount/1000
  end
  
  def bootstrap_flash_class_for(flash)
    alert_type = case flash
      when "error" then "danger"
      when "notice" then "success"
      else flash
    end
    "alert alert-#{alert_type}"
  end
end
