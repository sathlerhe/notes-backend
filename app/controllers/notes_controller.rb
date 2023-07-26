# frozen_string_literal: true

require 'sinatra/activerecord'
require 'sinatra'
require './app/models/notes'
require './app/errors/index'

class NotesController
  def create(params)
    note = {
      content: params[:content]
    }
    note = Notes.create(note)

    unless note.valid?
      return Error::BadRequest.new(
        "'content' must be sended. Given: #{params[:content]}"
      ).call
    end

    { result: note, status: 201 }
  end

  def return_all_notes
    notes = Notes.all
    { result: notes, status: 200 }
  end

  def return_specific_note(id)
    note = Notes.find(id)
    { result: note, status: 200 }
  rescue ActiveRecord::RecordNotFound
    Error::NotFound.new("Not found id #{params[:id]}").call
  end

  def update_note(params)
    note_body = {
      content: params[:content]
    }
    note = Notes.find(params[:id])
    note.update(note_body)
    { result: note, status: 200 }
  rescue ActiveRecord::RecordNotFound
    Error::NotFound.new("Not found id #{params[:id]}").call
  end

  def delete_note(params)
    note = Notes.find(params[:id])
    note.destroy
    { result: 'ok', status: 200 }.to_json
  rescue ActiveRecord::RecordNotFound
    Error::NotFound.new("Not found id #{params[:id]}").call
  end
end
