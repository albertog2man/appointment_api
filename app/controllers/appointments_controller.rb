class AppointmentsController < ApplicationController

	def index 
		appointments = Appointment.all
		search = Search.new
		relavent_params = search.clean_params(params)
		unless relavent_params.empty?
			relavent_params = search.standardize_params(relavent_params)
			unless relavent_params == false
				appointments = search.criteria(relavent_params)
				render json: appointments, status: 200
			end
		else
			render json: appointments, status: 200
		end
	end

	def create 
		appointment = Appointment.new(appointment_params)

		if appointment.check && appointment.save
			render json: appointment, status: 201, location: appointment
		else
			render json: appointment.errors, status: 422
		end
	end

	def update
		appointment = Appointment.find(params[:id])
		new_appointment = appointment.check_params(appointment_params)
		if new_appointment
			if appointment.update(new_appointment.attributes)
				render json: appointment, status: 200
			else
				render json: appointment.errors, status: 422
			end
		else
			render json: appointment.errors, status: 422
		end
	end 

	def destroy
		appointment = Appointment.find(params[:id])
		unless appointment.nil?
			appointment.destroy
			head 204
		else
			head 404
		end
	end

private
	def appointment_params
		params.require(:appointment).permit(:day,:month,:year,:first_name,:last_name,:start_time,:end_time)
	end
end
