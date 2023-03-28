
class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate_with_credentials(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to [:root], notice: 'Successful login!'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:login]
  end

end