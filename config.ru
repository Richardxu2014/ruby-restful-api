# require_relative './config/setup'
# require './main'
# run App

require_relative './config/setup'
require 'sinatra'

# pull in the helpers and controllers
Dir.glob('./controllers/*.rb').each { |file| require file }

map('/example'){ run ExampleController }
map('/'){ run ApplicationController }
