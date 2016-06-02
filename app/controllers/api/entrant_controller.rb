module Api
  class EntrantController < ApplicationController

    def index
        if !request.accept || request.accept == "*/*"
            if params[ :racer_id ].nil?
                render plain: "/api/races/#{params[:race_id]}/results"
            else
                render plain: "/api/racers/#{params[:racer_id]}/entries"
            end
        else
            @race = Race.find( params[ :race_id ] )
            @entrants = @race.entrants

            last_modified = @entrants.max( :updated_at )

            if stale? etag: @race, last_modified: last_modified
                fresh_when( last_modified: last_modified )
            end
            
        end
    end

    def show
        if !request.accept || request.accept == "*/*"
            if params[ :racer_id ].nil?
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            else
                render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
            end
        elsif request.headers[ 'Accept' ] == "application/json" 
            if params[ :racer_id ].nil?
                @result = Race.find( params[ :race_id ] ).entrants.where( :id => params[ :id ] ).first
                render :partial => "result", :object => @result
            else
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            end
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
        content_type = request.headers[ 'Content-Type' ]
        if !content_type || request.accept == "*/*"
            render plain: :nothing, status: :ok
        elsif content_type == "application/json" 
           if params[ :racer_id ].nil?
                @entrant = Race.find( params[ :race_id ] ).entrants.where( :id => params[ :id ] ).first
                result = params[ :result ]

                if params[ :result ][ :swim ]
                    @entrant.swim = @entrant.race.race.swim
                    @entrant.swim_secs = result[ :swim ].to_f
                end

                if params[ :result ][ :t1 ]
                    @entrant.t1 = @entrant.race.race.t1
                    @entrant.t1_secs = result[ :t1 ].to_f
                end

                if params[ :result ][ :bike ]
                    @entrant.bike = @entrant.race.race.bike
                    @entrant.bike_secs = result[ :bike ].to_f
                end

                if params[ :result ][ :t2 ]
                    @entrant.t2 = @entrant.race.race.t2
                    @entrant.t2_secs = result[ :t2 ].to_f
                end

                if params[ :result ][ :run ]
                    @entrant.run = @entrant.race.race.run
                    @entrant.run_secs = result[ :run ].to_f
                end

                @entrant.save

                render :json => { :name => "David" }.to_json
            else
                render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
            end
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