class WelcomeController < ApplicationController
  def index
    render json: { response: "Welcome to Tebgard.", status: 200 }, status: 200
  end
end
