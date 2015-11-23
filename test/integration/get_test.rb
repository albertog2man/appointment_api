require 'test_helper'

class AppointmentGetTest < ActionDispatch::IntegrationTest

	test 'list of all appointments' do
		get '/appointments'
		assert_equal 200, response.status
	end

	test 'filtering appointments by one criteria' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '05:00pm',end_time: '06:00pm', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Ed',last_name: 'toro',start_time: '09:00pm',end_time: '10:00pm', day: '13',month: '12', year: '2015'
		 )

		get '/appointments?start_time=05:00pm',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:first_name]}
		assert_includes names, "Bill"
		refute_includes names, "Ed"
	end

	test 'filtering appointments by two criteria' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '05:00pm',end_time: '06:00pm', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Ed',last_name: 'toro',start_time: '05:00pm',end_time: '10:00pm', day: '13',month: '12', year: '2015'
		 )

		get '/appointments?start_time=05:00pm&first_name=Bill',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:first_name]}
		assert_includes names, "Bill"
		refute_includes names, "Ed"
	end

	test 'filtering appointments by three criteria' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '05:00pm',end_time: '06:00pm', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '13',month: '12', year: '2015'
		 )

		get '/appointments?start_time=05:00pm&first_name=Bill&last_name=Toro',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:last_name]}
		assert_includes names, "Toro"
		refute_includes names, "Gonzo"
	end

	test 'filtering appointments by three criteria 2' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '05:00pm',end_time: '06:00pm', day: '13',month: '12', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Tom',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '14',month: '12', year: '2015'
		 )
		third_appointment = Appointment.create!(
			first_name: 'James',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '13',month: '13', year: '2015'
		 )
		fourth_appointment = Appointment.create!(
			first_name: 'Ed',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '13',month: '13', year: '2015'
		 )

		get '/appointments?start_time=05:00pm&day=14&month=12',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:first_name]}
		assert_includes names, "Tom"
		refute_includes names, "Bill"
	end

	test 'filtering appointments by three criteria 3' do
		first_appointment = Appointment.create!(
			first_name: 'Bill',last_name: 'Gonzo',start_time: '05:00pm',end_time: '06:00pm', day: '13',month: 'December', year: '2015'
		 )
		second_appointment = Appointment.create!(
			first_name: 'Tom',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '14',month: 'November', year: '2015'
		 )
		third_appointment = Appointment.create!(
			first_name: 'James',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '13',month: 'December', year: '2015'
		 )
		fourth_appointment = Appointment.create!(
			first_name: 'Ed',last_name: 'Toro',start_time: '05:00pm',end_time: '10:00pm', day: '13',month: 'December', year: '2015'
		 )

		get '/appointments?start_time=05:00pm&day=14&month=Nov',{},{'Accept' => Mime::JSON}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
		appointments = json(response.body)
		names = appointments.collect {|app| app[:first_name]}
		assert_includes names, "Tom"
		refute_includes names, "Bill"
	end

end