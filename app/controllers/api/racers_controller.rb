module Api
  class RacersController < ApplicationController

    def index
        if !request.accept || request.accept == "*/*"
            render plain: "/api/racers"
        else
            render plain: Racer.all
        end
    end

    def show
        if !request.accept || request.accept == "*/*"
            render plain: "/api/racers/#{params[:id]}"
        else
            render plain: Racer.find( params[ :id ] )
        end
    end

    def create
        if !request.accept || request.accept == "*/*"
            render plain: :nothing, status: :ok
        else
            #real implementation
        end
    end

    def update
        if !request.accept || request.accept == "*/*"
            render plain: :nothing, status: :ok
        else
            #real implementation
        end
    end

    def destroy
        if !request.accept || request.accept == "*/*"
            render plain: :nothing, status: :ok
        else
            #real implementation
        end
    end
    
  end
end