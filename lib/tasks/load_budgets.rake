task "adam" => :environment do
  require 'yaml'
  User.find_or_initialize_by(name: "Adam").tap do |user|
    user.email = ENV['YNAB_EMAIL']
    user.save!

    puts user.budgets.to_yaml
  end
end

task "ynab" => :environment do
  adam = User.find_by(email: ENV['YNAB_EMAIL'])
  require 'ynab'
  access_token = ENV['YNAB_ID']
  ynab = YnabApi::Client.new(access_token)

  budget_response = ynab.budgets.get_budgets
  budgets = budget_response.data.budgets

  budgets.each do |ynab_budget|
    adam.budgets.destroy_all

    puts "Budget Name: #{ynab_budget.name}"
    budget = adam.budgets.find_or_initialize_by(ynab_id: ynab_budget.id).tap do |b|
      b.name = ynab_budget.name
      b.currency = ynab_budget.currency_format.iso_code
      b.currency_decimals = ynab_budget.currency_format.decimal_digits
      b.currency_symbol = ynab_budget.currency_format.currency_symbol
      b.save!
    end

    categories_response = ynab.categories.get_categories(ynab_budget.id)
    ynab_category_groups = categories_response.data.category_groups
    ynab_category_groups.each do |ynab_category_group|
      if !ynab_category_group.hidden && !ynab_category_group.deleted && ynab_category_group.name != 'Internal Master Category'
        puts "  Category Group: #{ynab_category_group.name}"
        category_group = budget.category_groups.find_or_initialize_by(ynab_id: ynab_category_group.id).tap do |cg|
          cg.name = ynab_category_group.name
          cg.save!
        end

        ynab_category_group.categories.each do |ynab_category|
          if !ynab_category.hidden && !ynab_category.deleted
            puts "    Category: #{ynab_category.name}. Activity: $#{ynab_category.activity/1000}"
            category = category_group.categories.find_or_initialize_by(ynab_id: ynab_category.id).tap do |c|
              c.name = ynab_category.name
              c.save!
            end

            month = Time.now.beginning_of_month
            category.spendings.find_or_initialize_by(month: month).tap do |s|
              s.user = adam
              s.budgeted = ynab_category.budgeted
              s.activity = ynab_category.activity
              s.balance = ynab_category.balance
              s.save!
            end
          end
        end
      end
    end
  end
end
