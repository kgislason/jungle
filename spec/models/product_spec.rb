require 'rails_helper'

RSpec.describe Product, type: :model do

  describe '#id' do
    it 'should not exist for new records' do
      @product = Product.new
      expect(@product.id).to be_nil
    end

    describe 'Validations' do
      it 'should save product if all required fields are present' do
        @category = Category.new(name: "Test Category")
        @product = Product.new(
          name: "Test Product",
          price: 123,
          quantity: 100,
          category: @category
        )
        @product.save!
        expect(@product.valid?).to be true
        expect(@product.id).to be_present
      end

      it 'should not save if the name is not present' do
        @category = Category.new(name: "Test Category")
        @product = Product.new(
          name: nil,
          price: 123,
          quantity: 100,
          category: @category
        )
        expect(@product.valid?).to be false
        expect(@product.errors.full_messages.include? "Name can't be blank").to be true
      end

      it 'should not save if the Price is not present' do
        @category = Category.new(name: "Test Category")
        @product = Product.new(
          name: "Test Product",
          price_cents: nil,
          quantity: 100,
          category: @category
        )
        expect(@product.valid?).to be false
        expect(@product.errors.full_messages.include? "Price cents is not a number").to be true
      end

      it 'should not save if the quantity is not present' do
        @category = Category.new(name: "Test Category")
        @product = Product.new(
          name: "Test Product",
          price: 123,
          quantity: nil,
          category: @category
        )
        expect(@product.valid?).to be false
        expect(@product.errors.full_messages.include? "Quantity can't be blank").to be true
      end

      it 'should not save if the category is not present' do
        @category = Category.new(name: "Test Category")
        @product = Product.new(
          name: "Test Product",
          price: 123,
          quantity: 100,
          category: nil
        )
        puts @product.errors.full_messages[0]
        expect(@product.valid?).to be false
        expect(@product.errors.full_messages.include? "Category must exist").to be true
      end
    end
  end

end