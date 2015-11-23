class Appointment < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validates :day, presence: true
	validates :month, presence: true
	validates :year, presence: true

	def check
		@valid = true
		check_year
		check_month
		check_day
		check_time
		return false unless @valid
		check_availability		
		@valid
	end
	def time(time)
		convert_format_to_standard(time)

	end
	#this method returns either false or a object with time in standard form
	def check_params(params)

		self.assign_attributes(params)
		self.check
		return false unless @valid
		return self
	end

	def get_valid_params

	end


	def check_year
		#This will check to make sure the year is between 2013 - 2020
		@valid = false unless self.year =~ /^(201[3-9]|2020)$/
		@valid = false unless self.year.to_i >= Time.new.year
		#checks if its current year
		@current_year = true if self.year.to_i == Time.new.year
	end

	def check_month

		#checks if the month is a number between 1-12 or for the name or abriv and if its current or upcoming
		month_numeric = 0
		self.month.downcase.capitalize
		if Date::MONTHNAMES.index(self.month)
			month_numeric = Date::MONTHNAMES.index(self.month)
		elsif self.month =~ /^([1-9]|[1][0-2])$/
			month_numeric = self.month.to_i
			self.month = Date::MONTHNAMES[month_numeric]
		elsif self.month.length == 3
			Date::MONTHNAMES.each_with_index do |month,index|
				if index > 0
					if month[0..2] == self.month
						month_numeric = index
						self.month = month
					end
				end
			end
		else
			@valid = false
		end
		if @valid == true
			if @current_year == true
				@valid = false unless month_numeric >= Time.new.month
				#checks for current month
				@current_month = true if month_numeric == Time.new.month
			end
		end
		@month_numeric = month_numeric
	end

	def check_day
		#checks if the day is between 1 - 31 or 30, depends on the month chosen.
		@valid = false unless self.day.to_i <= Time.days_in_month(@month_numeric) && self.day.to_i > 0

		if @current_month 
			unless self.day.to_i >= Time.new.day
				@valid = false
			end
			@current_day = true if self.day.to_i == Time.new.day
		end
	end

	def check_time
		self.start_time = self.start_time.downcase
		self.end_time = self.end_time.downcase

		# Validates that time is in any of the accepted formats
		#**************************************************************************************************
		@valid = false unless self.start_time =~ /^([0-9]|0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]|)([ap][m]|)$/ #
		@valid = false unless self.end_time =~ /^([0-9]|0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]|)([ap][m]|)$/   #
		#**************************************************************************************************
		#converts time to standard time. e.g. 05:00pm
		unless self.start_time =~ /^1[0-2]:[0-5][0-9][ap][m]$/ || self.start_time =~ /^[0][1-9]:[0-5][0-9][ap][m]$/
			self.start_time = convert_format_to_standard(self.start_time)
		end
		unless self.end_time =~ /^1[0-2]:[0-5][0-9][ap][m]$/ || self.end_time =~ /^[0][1-9]:[0-5][0-9][ap][m]$/
			self.end_time = convert_format_to_standard(self.end_time)
		end

	end

	def convert_format_to_standard(time)

		case time 

			#**********************************************
			when /^([1-9]|[1][0-2])$/					  #
				if time.to_i == 12 						  #
					return time += ':00pm'				  #
				elsif time.to_i == 10 || time.to_i == 11  #
					return time += ':00am'				  # This checks to see if the time is just a number from 1-12
				elsif time.to_i >= 7 && time.to_i <= 9    # and if so then it will assume that the user ment business hours
					return time = "0#{time}:00am"         # so it will convert it to such
				elsif time.to_i <= 6 && time.to_i >= 1    #
					return time = "0#{time}:00pm"         #
				end                                       #
			#**********************************************	

			#**********************************************
			when /^([1-9]|[1][0-2])[ap][m]$/              #
				if time =~ /^[1-9][ap][m]$/				  #
					time = "0#{time}"					  # This checks to see if a user enterd a digit 1-12 with pm or am
					time = time.insert(2,':00')           # at the end of it.
				elsif time =~ /^[1][0-2][ap][m]$/         #
					time = time.insert(2,':00')           #
				end               						  #
			#**********************************************

			#**********************************************
			when /^[1-9]:[0-5][0-9]$/				  	  #
				time = "0#{time}"					  	  #
				hour = time[0..1].to_i                	  # Checks for when a user enters something like 5:00 
				if hour >= 7 && hour <= 9          	      # once again assuming they mean business hours
					return time += "am"              	  # 
				elsif hour <= 6 && hour >= 1          	  #
					return time += "pm"               	  #
				end 								 	  #
			#**********************************************

			#**********************************************
			when /^1[0-2]:[0-5][0-9]$/				  	  #	
				hour = time[0..1].to_i                	  # 
				if hour == 12 						  	  # Checks for when a user enters something like 10:00
					return time += 'pm'				  	  # gain assuming they mean business hours
				elsif hour == 10 || hour == 11        	  # 
					return time += 'am'				   	  #
				end 									  #
			#**********************************************

			#************************************************
			when /^([0][1-9]|[1-9]|1[0-2]):[0-5][0-9][ap][m]$/#
				if time =~ /^[1-9]:[0-5][0-9][ap][m]$/	    #
					time = "0#{time}"						#
					return time          					#
				elsif time =~ /^[0][1-9]:[0-5][0-9][ap][m]$/#Checks to see if user entered something like 10:30pm or 5:30pm
					return time                             #
				elsif time =~ /^1[0-2]:[0-5][0-9][ap][m]$/  #
					return time   						    #
				end  									    #
			#************************************************
		else
			@valid = false
		end
	end

	def check_availability
		return false unless @valid
		appointments = Appointment.all
		this_appointment_start = Time.parse("#{self.start_time}").to_i
		this_appointment_end = Time.parse("#{self.end_time}").to_i
		this_appointment_duration = this_appointment_start..this_appointment_end
		
		appointments.where(year: self.year, month: self.month, day: self.day).to_a.each do |app|
			other_appointment_start = Time.parse("#{app.start_time}").to_i
			other_appointment_end = Time.parse("#{app.end_time}").to_i
			other_appointment_duration = other_appointment_start..other_appointment_end

			if other_appointment_duration == this_appointment_duration
				@valid = false
				break
			end
		end
	end



end
