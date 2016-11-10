# we need to specify a database to connect to
# this is how Rake is allowed to create your tables
# through migrations
# without a db connection here, you have to create
# all tables by hand. Got it? Good.

require 'zlib'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

ActiveRecord::Base.establish_connection(
	:database => 'musical_api',
	:adapter => 'mysql2'
)