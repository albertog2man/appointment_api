class Search 


	# This method allows me to sort results with up to 3 criteria.
	# Probably one of those things I'll look back on in a year say "Oh god I was bad"
	
	def criteria(hash)
		arr_of_keys = []
		arr_of_values = []
		hash.each_with_index do |(key,value),index|
			break if index > 2
			arr_of_keys << key
			arr_of_values << value
		end
		case arr_of_keys.length
			when 1
				Appointment.where(
					arr_of_keys[0].to_sym => arr_of_values[0]
					)
			when 2
				Appointment.where(
					arr_of_keys[0].to_sym => arr_of_values[0],
					arr_of_keys[1].to_sym => arr_of_values[1]
					)
			when 3
				Appointment.where(
					arr_of_keys[0].to_sym => arr_of_values[0],
					arr_of_keys[1].to_sym => arr_of_values[1],
					arr_of_keys[2].to_sym => arr_of_values[2]
					)
		else 
			p "Arrays are out of bounds, this should never be printed"
		end
	end
end