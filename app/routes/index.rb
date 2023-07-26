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
    @body = JSON.parse(request.body.read).symbolize_keys
  end

  @payload = request.env['CONTENT_TYPE'] == 'application/json' ? @body : params
end

get '/notes' do
  response_result(NotesController.new.return_all_notes)
end

get '/notes/:id' do
  response_result(NotesController.new.return_specific_note(params[:id]))
end

post '/notes' do
  response_result(NotesController.new.create(@payload))
end

put '/notes/:id' do
  response_result(NotesController.new.update_note(params[:id], @payload))
end

delete '/notes/:id' do
  response_result(NotesController.new.delete_note(params))
end
