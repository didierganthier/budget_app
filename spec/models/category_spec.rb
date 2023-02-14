require '../rails_helper'

RSpec.describe Category, type: :model do
  before(:example) do
    @user = User.create(name: 'Didier', email: 'didier@gmail.com', password: 'test123')
  end

  context 'Validations' do
    it 'checks for name presence' do
      category = Category.new(author: @user, icon: 'https://cdn-icons-png.flaticon.com/512/3311/3311579.png')
      expect(category.valid?).to eq false
    end

    it 'checks if icon is there' do
      category = Category.new(author: @user, name: 'Sport')
      expect(category.valid?).to eq false
    end

    it 'checks if there\'s a name and an icon' do
      category = Category.new(author: @user, name: 'Sport', icon: 'https://cdn-icons-png.flaticon.com/512/3311/3311579.png')
      expect(category.valid?).to eq true
    end
  end

  context 'Associations' do
    it 'belongs to an author' do
      category = Category.reflect_on_association('author')
      expect(category.macro).to eq(:belongs_to)
    end

    it 'has many expenses' do
      category = Category.reflect_on_association('expenses')
      expect(category.macro).to eq(:has_many)
    end
  end
end