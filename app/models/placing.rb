class Placing
	include Mongoid::Document

	attr_accessor :name, :place

	field :name, type: String
	field :place, type: Integer

	def initialize( name, place )
		@name = name
		@place = place
	end

	def mongoize
    	{ :name => @name, :place => @place }
	end
  
	def self.demongoize( object )
		case object
			when Placing then object
			when Hash then
				Placing.new( object[ :name ], object[ :place ] ) 
      		else object
    	end
  	end

	def self.mongoize( object )
    	case object
      		when Placing then object.mongoize
      		when Hash then 
          		Placing.new( object[ :name ], object[ :place ] ).mongoize
      		else object
    	end
  	end
  
  	def self.evolve( object )
    	case object
      		when Placing then object.mongoize
      		else object
    	end
  	end
end