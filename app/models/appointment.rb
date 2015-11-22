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
		@valid
	end

	private 	
	def check_year
		#This will check to make sure the year is either current or next 5
		@valid = false unless self.year =~ /^(201[5-9]|2020)$/
		#checks if its current year
		@current_year = true if self.year.to_i == Time.new.year
	end

	def check_month
		#checks if the month is a number between 1-12 and if its current or upcoming
		@valid = false unless self.month =~ /^[1-9]([0-2]|)$/
		if @current_year == true
			@valid = false unless self.month.to_i >= Time.new.month
			#checks for current month
			@current_month = true if self.month.to_i == Time.new.month
		end
	end

	def check_day
		#checks if the day is between 1 - 31 or 30, depends on the month chosen.
		@valid = false unless self.day.to_i <= Time.days_in_month(self.month.to_i) && self.day.to_i > 0

		if @current_month 
			@valid = false unless self.day.to.i >= Time.new.day
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

		#converts time to e.g. 05:00pm
		convert_format_to_standard(self.start_time)
		convert_format_to_standard(self.end_time)

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
					return time = "0#{time}:00am"         #
				end                                       #
			#**********************************************	

			when /^([1-9]|[1][0-2])[ap][m]$/
				if time[1] == 'p' || time[2] == 'p'

		end
	end
end


















