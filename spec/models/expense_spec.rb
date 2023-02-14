require '../rails_helper'

RSpec.describe Expense, type: :model do
  before(:example) do
    @user = User.create(name: 'Didier', email: 'didier@gmail.com', password: 'test123')
    @category = Category.new(author: @user, name: 'Sport', icon: 'https://cdn-icons-png.flaticon.com/512/3311/3311579.png')
  end

  context 'Validations' do
    it 'should have a name' do
      expense = Expense.new(author: @user, amount: 200, category_ids: [@category.id])
      expect(expense.valid?).to eq false
    end

    it 'should have an amount' do
      expense = Expense.new(author: @user, name: 'Buy sneakers', category_ids: [@category.id])
      expect(expense.valid?).to eq false
    end

    it 'should have both a name and an amount' do
      expense = Expense.new(author: @user, name: 'Buy sneakers', amount: 745, category_ids: [@category.id])
      expect(expense.valid?).to eq true
    end
  end

  context 'Associations' do
    it 'belongs to an author' do
      expense = Expense.reflect_on_association('author')
      expect(expense.macro).to eq(:belongs_to)
    end

    it 'has many categories' do
      expense = Expense.reflect_on_association('categories')
      expect(expense.macro).to eq(:has_many)
    end
  end
end