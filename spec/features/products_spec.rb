require 'rails_helper'

RSpec.describe 'Products' do
  let(:user1) { User.create(email: 'admin@test.de', password: '123456', role: 1) }
  let(:user2) { User.create(email: 'user@test.de', password: '123456', role: 0) }
  let!(:shop) { Shop.create(name: 'Amazon') }
  let!(:product1) { Product.create(
                    name: 'Buch',
                    description: 'Ein schönes Buch',
                    price: '9.99',
                    user: user1,
                    shop: shop) }
  let!(:product2) { Product.create(
                    name: 'Stift',
                    description: 'Ein schöner Stift',
                    price: '1.99',
                    user: user2,
                    shop: shop) }

  context '.index' do
    before(:each) do
      sign_in(user1)
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
      sign_in(user1)
      visit '/products'
    end

    it 'creates new products' do
      create_new_product
      expect(page).to have_content('Test Title')
    end

    it 'assigns new products to signed in user' do
      create_new_product
      expect(Product.last.user).to eq(user1)
    end
  end

  context '.update' do
    before(:each) do
      sign_in(user1)
      visit '/products'
    end

    it 'can update a product' do
      click_link 'Edit'
      fill_in 'Name', with: 'Buch updated'
      click_button 'Update Product'
      expect(page).to have_content('Product was successfully updated.')
    end
  end

  # context '.destroy' do
  #   it 'can delete a product' do
  #     delete_button = find(:xpath, '//*[@id="product_1"]/td[6]/a[3]')
  #     delete_button.click
  #     expect(page).to have_content('Product was successfully destroyed.')
  #   end
  # end

  # context '.product_mail' do
  #   it 'can request more information about the product' do
  #     click_link 'Request more info'
  #     expect(page).to have_content('Email was sent.')
  #   end
  # end
end

private

def create_new_product
  click_link 'New'
  fill_in 'Name', with: 'Test Title'
  fill_in 'Description', with: 'Test Description'
  fill_in 'Price', with: '1.99'
  click_button 'Create Product'
end


