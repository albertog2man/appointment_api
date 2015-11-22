class AppointmentsController < ApplicationController

	def index 
		appointments = Appointment.all
		if start_time = params[:start_time]
			appointments = appointments.where(start_time: start_time)
		end
		render json: appointments, status: 200
	end

	def create 
		appointment = Appointment.new(appointment_params)
		if appointment.save
			render json: appointment, status: 201, location: appointment
		end
	end

private
	def appointment_params
		params.require(:appointment).permit(:first_name,:last_name,:start_time,:end_time)
	end
end
