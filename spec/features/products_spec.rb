require 'rails_helper'

RSpec.describe 'Products', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:product1) { FactoryBot.create(:product1) }
  let!(:product2) { FactoryBot.create(:product2) }

  context '.index' do
    before(:each) do
      sign_in(user)
      visit '/products'
    end

    it 'loads properly' do
      expect(page).to have_content('My Products')
    end

    it 'shows products that belong to signed in user' do
      expect(page).to have_content(product1.name)
    end

    it 'does not show products that belong to other users' do
      expect(page).not_to have_content(product2.name)
    end
  end

  context '.create' do
    before(:each) do
      sign_in(user)
      visit '/products'
    end

    it 'creates new products' do
      create_new_product
      expect(page).to have_content('Test Title')
    end

    it 'assigns new products to signed in user' do
      create_new_product
      expect(Product.last.user).to eq(user)
    end
  end
end

private

def create_new_product
  click_link 'New'
  fill_in 'Name', with: 'Test Title'
  fill_in 'Description', with: 'Test Description'
  fill_in 'Price', with: '1.99'
  click_button 'Create Product'
end