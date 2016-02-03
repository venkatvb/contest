class ContestsController < ApplicationController
  before_action :sign_in_user, :only => [:index, :validate, :success]
  def index
    # Not started
    render 'notstarted'
    # End of Not started

    # Ended
    # render 'ended'
    # End of Ended
    
    if get_level > max_level
      flash[:success] = "Congrats! You cleared the problem set."
      render 'success'      
    else
      @name = Problem.find_by_level(get_level).url
      @problem = Problem.new
    end
  end

  def validate
    @answer = Problem.find_by_level(get_level).answer.split.join.downcase
    if @answer == params[:problem][:answer].split.join.downcase
      Account.where(:id => get_account_id).update_all(level: get_level+1, time: DateTime.now )
      flash[:success] = "Well done! Nailed it!"
    else
      flash[:danger] = "Ohh! nice try. Try again!!"
    end
    redirect_to "/"
  end

  def create
    require 'net/http'
  	@account = Account.new(account_params)
  	if verify_recaptcha(model: @account) && @account.save
  		redirect_to sessions_signin_path
  	else
  		render 'signup'
  	end
  end

  def leaderboard
    @accounts = Account.select(:name, :level, :college, :time).order(level: :desc, time: :asc)
    @max_level = max_level
  end

  def signup
  	@account = Account.new
  end

  def account_params
  	params.require(:account).permit(:name, :email, :college, :register_number, :department, :year, :phone, :password, :password_confirmation)	
  end

  private :account_params
end
