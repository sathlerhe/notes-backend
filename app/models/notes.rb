# frozen_string_literal: true

class Notes < ActiveRecord::Base
  validates :content, presence: true
end
