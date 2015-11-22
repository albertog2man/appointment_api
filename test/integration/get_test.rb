require 'test_helper'

class AppointmentGetTest < ActionDispatch::IntegrationTest

	test 'list of all appointments' do
		get '/appointments'
		assert_equal 200, response.status
	end

	test 'filtering appointments by one criteria' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '5:00',end_time: '6:00', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Ed',last_name: 'toro',start_time: '9:00',end_time: '10:00', day: '13',month: '12', year: '2015'
		 )

		get '/appointments?start_time=5:00',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:first_name]}
		assert_includes names, "Bill"
		refute_includes names, "Ed"
	end

	test 'filtering appointments by two criteria' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '5:00',end_time: '6:00', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Ed',last_name: 'toro',start_time: '5:00',end_time: '10:00', day: '13',month: '12', year: '2015'
		 )

		get '/appointments?start_time=5:00&first_name=Bill',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:first_name]}
		assert_includes names, "Bill"
		refute_includes names, "Ed"
	end

	test 'filtering appointments by three criteria' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '5:00',end_time: '6:00', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Toro',start_time: '5:00',end_time: '10:00', day: '13',month: '12', year: '2015'
		 )

		get '/appointments?start_time=5:00&first_name=Bill&last_name=Toro',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:last_name]}
		assert_includes names, "Toro"
		refute_includes names, "Gonzo"
	end

end