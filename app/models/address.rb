class Address
	include Mongoid::Document

	attr_accessor :city, :state, :location

	field :city, type: String
	field :state, type: String
	field :location, type: Point

	def initialize( city = nil, state = nil, location = nil )
		@city = city
		@state = state
		@location = location
	end

	def mongoize
    	{ :city => @city, :state => @state, :loc => @location.mongoize }
	end
  
	def self.demongoize( object )
		case object
			when Address then object
			when Hash then
				Address.new( object[ :city ], object[ :state ], Point.demongoize( object[ :loc ] ) ) 
      		else object
    	end
  	end

	def self.mongoize( object )
    	case object
      		when Address then object.mongoize
      		when Hash then 
          		Address.new( object[ :city ], object[ :state ], object[ :loc ] ).mongoize
      		else object
    	end
  	end
  
  	def self.evolve( object )
    	case object
      		when Address then object.mongoize
      		else object
    	end
  	end

end