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
		@valid
	end

	private 

	
	def check_year
		#This will check to make sure the year is either current or next 5
		@valid = false unless self.year =~ /^(201[5-9]|2020)$/
		#checks if its current year
		@current_year = true if self.year == Time.new.year.to_s
		

	end

	def check_month
		#checks if the month is a number between 1-12 and if its current or upcoming
		@valid = false unless self.month =~ /^[1-9]([0-2]|)$/
		if @current_year == true
			@valid = false unless self.month.to_i >= Time.new.month
		end
		#checks for current month
		@current_month = true if self.month == Time.new.month.to_s
	end

	def check_day
		@valid = false unless self.day.to_i <= Time.days_in_month(self.month.to_i) && self.day.to_i > 0
	end
end
