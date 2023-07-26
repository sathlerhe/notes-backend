# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'
require './app/routes/index'
Dotenv.load

set :database, { adapter: 'sqlite3', database: ENV.fetch('DB_PATH', nil) }
