module SessionsHelper
	def sign_in(account)
		cookies.permanent[:remember_token] = account.remember_token
		self.current_account = account
	end

	def sign_in_user
		unless signed_in?
	        flash[:danger] = "Please log in."
	        redirect_to sessions_signin_url
	    end
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_account = nil
	end
	
	def signed_in?
		!current_account.nil?
	end
	
	def current_account=(account)
		@current_account = account
	end

	def current_account
		@current_account = Account.find_by_remember_token(cookies[:remember_token])
	end

	def get_name
		@current_account.name
	end

	def get_account_id
		@current_account.id
	end

	def get_level
		@current_account.level
	end
end
