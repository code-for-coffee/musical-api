require 'sinatra/base'

# controllers
require './controllers/application_controller'

# models
require './models/artist'
require './models/song'
require './models/account'

# map controllers to routes

map('/') { run ApplicationController }