class TestsController < ApplicationController
  
    def show
      render json: { message: "If you see this, you're in!" }
    end
  end