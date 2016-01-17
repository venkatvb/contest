class ContestsController < ApplicationController
  before_action :sign_in_user, :only => [:index, :validate, :success]
  def index
    max_level = Problem.maximum(:level)
    if get_level >= max_level
      flash[:success] = "Congrats! You cleared the problem set."
      render 'success'      
    else
      @name = Problem.find_by_level(get_level).url
      @problem = Problem.new
    end
  end

  def validate
    @answer = Problem.find_by_level(get_level).answer.strip
    if @answer == params[:problem][:answer].strip
      Account.where(:id => get_account_id).update_all(level: get_level+1, time: DateTime.now )
      flash[:success] = "Well done! Nailed it!"
    else
      flash[:danger] = "Ohh! nice try. Try again!!"
    end
    redirect_to "/"
  end

  def create
  	@account = Account.new(account_params)
  	if @account.save
  		redirect_to '/'
  	else
  		render 'signup'
  	end
  end

  def leaderboard
    @accounts = Account.select(:name, :level, :time).order(level: :desc, time: :asc)
  end

  def signup
  	@account = Account.new
  end

  def account_params
  	params.require(:account).permit(:name, :email, :college, :register_number, :department, :year, :phone, :password, :password_confirmation)	
  end

  private :account_params
end
