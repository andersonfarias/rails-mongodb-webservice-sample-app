class RunResult < LegResult
	
	field :mmile, as: :minute_mile, type: Float

	def calc_ave
		if not event.nil? and not secs.nil?
			self.minute_mile = ( secs / 60 ) / event.miles
		end
		self.minute_mile
	end

end