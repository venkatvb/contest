class SessionsController < ApplicationController
  def create
  	account = Account.find_by_email(params[:session][:email])
  	if account and account.authenticate(params[:session][:password])
  		sign_in account
  		flash[:success] = "Login success!"
      redirect_to contests_index_path
  	else
  		flash[:danger] = "Oh snap! Invalid username or password"
  		render 'new'
  	end
  end

  def new
    if signed_in?
      flash[:danger] = "You were already signed in!"
      redirect_to contests_index_path
    end
  	@current_account = nil
  end

  def destroy
  	sign_out
  	redirect_to contests_index_path
  end
end
