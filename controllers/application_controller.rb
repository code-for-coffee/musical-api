class ApplicationController < Sinatra::Base

	@account_message = ""

	require 'bundler'
	Bundler.require

	ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'musical_api'
	)

	set :public_folder, File.expand_path('../public', __FILE__)
	set :views, File.expand_path('../views', __FILE__)
	enable :sessions

	not_found do
		erb :not_found	#404 page
	end

	def does_user_exist?(username)
		user = Account.find_by(:username => username.to_s)
		if user
			return true
		else
			return false
		end
	end

	def is_not_authenticated
		session[:user].nil?	#bool
	end

	get '/' do
		{:message => 'Welcome'}.to_json
	end

end