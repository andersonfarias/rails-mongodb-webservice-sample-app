class BikeResult < LegResult

	field :mph, type: Float

	def calc_ave
		if not event.nil? and not secs.nil?
			self.mph = event.miles * 3600 / secs
		end
		self.mph
	end

end