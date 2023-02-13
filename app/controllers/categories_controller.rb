class CategoriesController < ApplicationController
    def index
      @categories = current_user.categories
    end
  
    def show
      @category = Category.find(params[:id])
      @expenses = @category.expenses.order(created_at: :desc)
      @total = @expenses.sum(:amount)
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      @category.author = current_user
  
      if @category.save
        flash[:notice] = 'Category was successfully created'
        redirect_to categories_path
      else
        render :new, status: :unprocessable_entity
      end
    end
end
