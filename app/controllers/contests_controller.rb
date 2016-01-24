class ContestsController < ApplicationController
	
	before_action :sign_in_user, :only => [:index, :validate, :success]
	
	@@congratsMessage = "Congrats! You cleared the problem set."
	@@successfulSubmissionMessage = "Well done! Nailed it!"
	@@wrongSubmissionMessage = "Ohh! nice try. Try again!!"
	@@submissionLimitMessage = "Next submission can be done only after 30 seconds."
	@@answerEmptyMessage = "Oop! You haven't keyed anything."
	@@accessDeniedMessage = "Ooh Snap! You dont have access to the page you requested before, so directed to your latest level."
	@@tresholdSubmissionTimeDifference = 30
	
	def dashboard
		@problems = Problem.all
	end

	def index
		@problemId = params[:id].to_i
		if !validProblemId?(@problemId)
			@problemId = get_problem_id
			flash[:danger] = @@accessDeniedMessage
		end
		@name = Problem.find(@problemId).url
		@problem = Problem.new
	end

	def validate
		if cannotSubmit?
			flash[:danger] = @@submissionLimitMessage 
		else
			givenAnswer = params[:problem][:answer].strip
			storeSubmission(givenAnswer)
			if givenAnswer.empty?
				flash[:danger] = @@answerEmptyMessage
			else
				@answer = Problem.find_by_level(get_level).answer.strip
				if @answer == givenAnswer
					Account.where(:id => get_account_id).update_all(level: get_level+1, time: DateTime.now )
					flash[:success] = @@successfulSubmissionMessage
				else
					flash[:danger] = @@wrongSubmissionMessage
				end
			end
		end
		redirect_to "/"
	end

	def create
		require 'net/http'
		@account = Account.new(account_params)
		if verify_recaptcha(model: @account) && @account.save
			redirect_to '/'
		else
			render 'signup'
		end
	end

	def leaderboard
		@accounts = Account.select(:name, :level, :time).order(level: :desc, time: :asc)
		@max_level = max_level
	end

	def signup
		@account = Account.new
	end

	def account_params
		params.require(:account).permit(:name, :email, :college, :register_number, :department, :year, :phone, :password, :password_confirmation)	
	end

	def canSubmit?
		lastSubmission = Submission.where(account_id: 6, problem_id: 1).select(:time).last
		if lastSubmission.nil?
			return true
		else
			if time_elapsed(lastSubmission.time.to_datetime) > @@tresholdSubmissionTimeDifference
				return true
			else 
				return false
			end
		end
	end

	def cannotSubmit?
		!canSubmit?
	end

	def time_elapsed(givenTime)
		currentTime = DateTime.now
		difference = ((currentTime - givenTime) * 60 * 24 * 24).to_i
		setSubmissionLimitMessage(difference)
		return difference
	end

	def storeSubmission(input)
		Submission.new(account_id: get_account_id, problem_id: get_problem_id, time: DateTime.now, answer: input).save
	end

	def setSubmissionLimitMessage(time)
		@@submissionLimitMessage = "Next submission can be done only after #{@@tresholdSubmissionTimeDifference - time} seconds."
	end

	def validProblemId?(problemId)
		problemId > 0 and problemId <= get_problem_id		
	end

	private :account_params, :canSubmit?, :cannotSubmit?, :time_elapsed, :storeSubmission, :setSubmissionLimitMessage, :validProblemId?

end
