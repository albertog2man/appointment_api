class AppointmentsController < ApplicationController

	def index 
		appointments = Appointment.all
		params_clone = params
		params_clone.delete(:controller)
		params_clone.delete(:action)
		unless params_clone.empty?
			appointments = Search.new.criteria(params_clone)
		end
		render json: appointments, status: 200
	end

	def create 
		appointment = Appointment.new(appointment_params)

		# if appointment.save
		if appointment.check && appointment.save
			render json: appointment, status: 201, location: appointment
		else
			render json: appointment.errors, status: 422
		end
	end

	def update
		appointment = Appointment.find(params[:id])
		if appointment.update(appointment_params)
			render json: appointment, status: 200
		else
			render json: appointment.errors, status: 422
		end
	end 

	def destroy
		appointment = Appointment.find(params[:id])
		appointment.destroy
		head 204
	end

private
	def appointment_params
		params.require(:appointment).permit(:day,:month,:year,:first_name,:last_name,:start_time,:end_time)
	end
end
