class AccountController < ApplicationController

	@username = ''

	get '/' do
		# login/registration page
		erb :login
	end

	post '/register' do
		# accept the params from a post
		# to create a user
		# hint: bcrypt
		@username = params[:username]
		@password = params[:password]
		@email = params[:email]
		if does_user_exist?(@username) == true
			@account_message = "User already exists."
			return erb :login_notice
		end

		password_salt = BCrypt::Engine.generate_salt
		password_hash = BCrypt::Engine.hash_secret(@password, password_salt)

		@model = Account.new
		@model.username = @username
		@model.email = @email
		@model.password_hash = password_hash
		@model.password_salt = password_salt
		@model.save

		@account_message = "You have successfully registered and you are logged in :)"

		session[:user] = @model
		@username = session[:user][:username]
		#binding.pry

		erb :login_notice

	end

	post '/login' do
		# params { :username, :password, :email }
		@username = params[:username]
		@password = params[:password]
		# accept params from a post
		# to check if a user exists
		# and if so, log them in
		if does_user_exist?(@username) == false
			@account_message = "User already exists."
			#binding.pry
			return erb :login_notice
		end

		#binding.pry
		@model = Account.where(:username => @username).first!
		if @model.password_hash == BCrypt::Engine.hash_secret(@password, @model.password_salt)
			@account_message = "Welcome back!"
			session[:user] = @model

			@username = session[:user][:username]
			#binding.pry

			return erb :login_notice
		else
			@account_message = "Sorry, you password did not match. Try again?"
			return erb :login_notice
		end

	end

	get '/logout' do
		# user peaces out
		# set session to nil
		# they will then need to login again
		session[:user] = nil
		@username = nil
		redirect '/'
	end

	get '/supersecret' do
		# our test of user authentication
		# hide some hash/json
		# and only show it to registered, logged in
		# users
		if is_not_authenticated == false
			erb :secret_club
		else
			@account_message = "You shall not pass!"
			erb :login_notice
		end
	end
end