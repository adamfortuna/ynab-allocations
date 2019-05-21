module Ynab
  class AllocationsController < ApplicationController
    layout 'ynab'

    def create
      @allocation = current_user.allocations.new(params[:ynab_allocation].permit(:name, :allocate_from))
      if @allocation.save
        redirect_to ynab_allocation_path(@allocation)
      else
        render :edit
      end
    end

    def edit
      @allocation = current_user.allocations.find(params[:id])
    end

    def update
      @allocation = current_user.allocations.find(params[:id])

      if @allocation.update(params[:ynab_allocation].permit(:name, :allocate_from))
        redirect_to edit_ynab_allocation_path(@allocation), notice: "Allocation Updated!"
      else
        render :edit
      end
    end

  end
end
