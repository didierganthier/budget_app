require '../rails_helper'

RSpec.describe 'Categories', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Didier', email: 'didier@gmail.com', password: 'anything')
      sign_in @user

      @category = Category.create(author: @user, name: 'Cheese', icon: 'https://cdn-icons-png.flaticon.com/512/4063/4063291.png')
      visit categories_path
    end

    it 'renders category name' do
      expect(page).to have_content(@category.name)
    end

    it 'renders category icon' do
      find("img[src='#{@category.icon}']")
    end

    it 'renders category\'s total expenses' do
      expect(page).to have_content(@category.expenses.sum(:amount))
    end

    it 'redirects to specific category page' do
      click_link @category.name
      expect(page).to have_current_path(category_path(@category))
    end

    it 'redirects to form to create new category' do
      click_link 'Add new category'
      expect(page).to have_current_path(new_category_path)
    end
  end
  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Didier', email: 'didier@gmail.com', password: 'anything')
      sign_in @user

      @category = Category.create(author: @user, name: 'Cheese', icon: 'https://cdn-icons-png.flaticon.com/512/4063/4063291.png')

      @expense = Expense.create(author: @user, name: 'Buy Cake', amount: 100, category_ids: [@category.id])
      visit category_path(@category)
    end

    it 'renders category name' do
      expect(page).to have_content(@category.name)
    end

    it 'renders total expenses of category' do
      expect(page).to have_content(@category.expenses.sum(:amount))
    end

    it 'renders expense name' do
      expect(page).to have_content(@expense.name)
    end

    it 'renders expense amount' do
      expect(page).to have_content(@expense.amount)
    end

    it 'redirects to form to create new expense' do
      click_link 'Add new expense'
      expect(page).to have_current_path(new_category_expense_path(@category))
    end

    it 'redirects to categories page' do
      click_link 'Back'
      expect(page).to have_current_path(categories_path)
    end
  end
end