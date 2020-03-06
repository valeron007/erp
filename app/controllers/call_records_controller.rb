class CallRecordsController < ApplicationController
  after_action :verify_authorized
  def index
    authorize User
  end
end