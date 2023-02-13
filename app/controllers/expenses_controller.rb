class ExpensesController < ApplicationController
    def new
        @expense = Expense.new
        @category = Category.find(params[:category_id])
    end

    def create
        @category = Category.find(params[:category_id])
        
        if expense_params[:category_ids].length == 1
            flash[:alert] = 'Must select at least one category'
            redirect_to new_category_expense_path(@category)
        else
            @category = Category.find(params[:category_id])
            @expense = Expense.new(expense_params)
            @expense.author = current_user

            if @expense.save
                flash[:notice] = 'Expense created successfully'
                redirect_to @category
            else
                flash[:alert] = 'Expense was not created'
                render :new, status: :unprocessable_entity
            end
        end
    end

    private

    def expense_params
      params.require(:expense).permit(:name, :amount, category_ids: [])
    end
end
