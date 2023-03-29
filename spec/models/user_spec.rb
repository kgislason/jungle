require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#id' do
    it 'Should not exist for new records' do
      @user = User.new
      expect(@user.id).to be_nil
    end   
  end

  describe 'Validations' do
    it 'Should save new user if all required fields are present' do
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

    describe 'Password' do
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

      it 'Password should not be nil' do
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

      it 'Password_confirmation should not be nil' do
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

      it 'should be a minimum of 3 characters' do
        @user = User.new(        
          first_name: "Test",
          last_name: "Last",
          email: "kristy@mailinator.com",
          password: "12",
          password_confirmation: "12"
        )
        expect(@user.valid?).to be false
        expect(@user.errors.full_messages.include? "Password is too short (minimum is 3 characters)").to be true
      end
    end

    it 'User email should not be nil' do
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

    it 'Email should be unique' do
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

    it 'User first name should not be nil' do
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

    it 'User last name should not be nil' do
      @user = User.new(        
        first_name: "Test",
        last_name: nil,
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include? "Last name can't be blank").to be true
    end

  end

  describe '.authenticate_with_credentials' do
    
    it "Should return the user object if email and password match" do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last Name",
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      @user.save!

      @session = User.authenticate_with_credentials("kristy@mailinator.com", "12345")

      expect(@session.email).to eq(@user.email)
    end

    it "Should return nil if email and password do not match" do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last Name",
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      @user.save!

      @session = User.authenticate_with_credentials("kristy@mailinator.com", "54321")

      expect(@session).to eq(nil)
    end

    it "Should return the user object if the email has white space" do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last Name",
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      @user.save!

      @session = User.authenticate_with_credentials("    kristy@mailinator.com    ", "12345")
      expect(@session.email).to eq(@user.email)
    end

    it "Should return the user object if the email has upper or lowercase letters" do
      @user = User.new(        
        first_name: "Test",
        last_name: "Last Name",
        email: "kristy@mailinator.com",
        password: "12345",
        password_confirmation: "12345"
      )
      @user.save!
      @session = User.authenticate_with_credentials("KRISTY@mailinator.com", "12345")
      expect(@session.email).to eq(@user.email)
    end
  end


end