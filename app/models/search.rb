class Search 

	# This method allows me to sort results with up to 3 criteria.

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
	# This is HUGE wettness but I would have to refactor my 
	# entire code to use its duplicate in the appointments class. 
	# I'll never do this again. - Hackpology
	def clean_params(params)
		params.delete(:controller)
		params.delete(:action)
		params
	end

	def standardize_params(params)
		appointment = Appointment.new
		@valid = true
		params.each do |key, value|
			
			case key
			when "start_time"
				value = appointment.time(value)
				params[key] = value
			when "end_time" 
				value = appointment.time(value)
				params[key] = value
			when "year"
				@valid = false unless value =~ /^(201[3-9]|2020)$/
			when "month"
				if Date::MONTHNAMES.index(value)
				elsif value =~ /^([1-9]|[1][0-2])$/
					value = Date::MONTHNAMES[value.to_i]
					params[key] = value
				elsif value.length == 3
					value = value.downcase.capitalize
					Date::MONTHNAMES.each_with_index do |month,index|
						if index > 0
							if month[0..2] == value
								value = month
								params[key] = value
							end
						end
					end
				else
					@valid = false
				end
			when "day"
				@valid = false if value.to_i > 31 || value.to_i < 1
			when "first_name", "last_name"
				value.downcase.capitalize
				params[key] = value
			end
		end
		return false unless @valid
		p params
		params
	end
end