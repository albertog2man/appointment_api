class AppointmentsController < ApplicationController

	def index 
		appointment = Appointment.all
		render json: appointment, status 200
	end
end
