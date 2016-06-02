class SwimResult < LegResult

	field :pace_100, type: Float

	def calc_ave
		if not event.nil? and not secs.nil?
			self.pace_100 = secs / ( event.meters / 100 )
		end
		self.pace_100
	end

end