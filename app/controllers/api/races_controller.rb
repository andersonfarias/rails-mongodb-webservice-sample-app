module Api
  class RacesController < ApplicationController

    def index
		if !request.accept || request.accept == "*/*"
			render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
		else
			render plain: Race.all
		end
    end

    def show
		if !request.accept || request.accept == "*/*"
			render plain: "/api/races/#{params[:id]}"
		else
			@race = Race.find( params[ :id ] )
			template = "not_supported_content-type"
			request.headers[ 'Accept' ].split( ',' ).each do | content_type |
				template = case content_type
					when "application/xml" then "api/races/index.xml.builder"
					when "application/json" then "api/races/index.json.jbuilder"
					else "not_supported_content-type"
				end
			end
			render template
		end
    end

    def create
		if !request.accept || request.accept == "*/*"
			render plain: "#{params[:race][:name]}"
		elsif not request.accept.nil? and not request.accept == "*/*"
			@race = Race.create( JSON.parse( request.body.read )[ "race" ] )
			render plain: @race.name, status: :created
		end
    end

    def update
    	@race = Race.find( params[ :id ] )
    	@race.update( JSON.parse( request.body.read )[ "race" ] )
		render json: @race
    end

    def destroy
    	Race.find( params[ :id ] ).destroy
		render :nothing => true, :status => :no_content
    end

    rescue_from Mongoid::Errors::DocumentNotFound do | exception |
    	template = case request.headers[ 'Accept' ]
			when "application/xml" then "api/error_msg.xml.builder"
			when "application/json" then "api/error_msg.json.jbuilder"
			else "api/error_msg.text.raw"
		end

    	render :status => :not_found, :template => template, :locals => { :msg => "woops: cannot find race[#{params[:id]}]" }
	end

	rescue_from ActionView::MissingTemplate do | exception |
		Rails.logger.debug exception

		content_type = request.headers[ 'Accept' ]
		render :status => 415, plain: "woops: we do not support that content-type[#{content_type}]"
	end

  end
end