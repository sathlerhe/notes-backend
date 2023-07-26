# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require './app/controllers/notes_controller'

def response_result(result)
  res = result
  body res.to_json
  status res[:status]
end

before do
  if request.env['CONTENT_TYPE'] == 'application/json' && !params[:path]
    @params = JSON.parse(request.body.read).symbolize_keys
  end
end

get '/notes' do
  response_result(NotesController.new.return_all_notes)
end

get '/notes/:id' do
  response_result(NotesController.new.return_specific_note(params[:id]))
end

post '/notes' do
  response_result(NotesController.new.create(params))
end

put '/notes/:id' do
  response_result(NotesController.new.update_note(params))
end

delete '/notes/:id' do
  response_result(NotesController.new.delete_note(params))
end
