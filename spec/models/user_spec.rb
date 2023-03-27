require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#id' do
    it 'should not exist for new records' do
      @user = User.new
      expect(@user.id).to be_nil
    end   
  end

  describe 'Validations' do
    it 'should save user if all required fields are present' do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last",
        email: "kristy@mailinator.com",
        password: "123456",
        password_confirmation: "123456"
      )
      @user.save!
      expect(@user.valid?).to be true
      expect(@user.id).to be_present
    end

    it 'Password and password_confirmation should match' do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last",
        email: "kristy@mailinator.com",
        password: "123456",
        password_confirmation: "12345"
      )
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.include? "Password confirmation doesn't match Password").to be true
    end

    it 'Password is not nil' do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last",
        email: "kristy@mailinator.com",
        password: nil,
        password_confirmation: "12345"
      )
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.include? "Password can't be blank").to be true
    end

    it 'Password_confirmation is not nil' do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last",
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: nil
      )
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.include? "Password confirmation can't be blank").to be true
    end

    it 'User email is not nil' do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last",
        email: nil,
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.include? "Email can't be blank").to be true
    end

    before {
      @user1 = User.create(
        first_name: "First",
        last_name: "Last",
        email: "kristy1@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
    }

    it 'Should validate uniqueness of email' do
      @user2 = User.create(
        first_name: "Second",
        last_name: "Last",
        email: "kristy1@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user2.valid?).to be false
      expect(@user2.errors.full_messages.include? "Email has already been taken").to be true
    end

    it 'User first name is not nil' do
      @user = User.new(        
        first_name: nil,
        last_name: "Last",
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.include? "First name can't be blank").to be true
    end

    it 'User last name is not nil' do
      @user = User.new(        
        first_name: "Test",
        last_name: nil,
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.include? "Last name can't be blank").to be true
    end

  end


end