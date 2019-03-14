class WelcomeController < ApplicationController
  def index
    redirect_to :locations
  end
end
