class AppointmentPostTest < ActionDispatch::IntegrationTest
	test 'creates appointment' do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'5:00', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type

		appointment = json(response.body)
		assert_equal appointment_url(appointment[:id]), response.location
	end

	test 'cant create invalid appointment' do
		post '/appointments',
		{ appointment:
			{first_name: nil, last_name: 'Gonzo', start_time:'5:00', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 422, response.status
		assert_equal Mime::JSON, response.content_type
	end

	test 'cant create invalid appointment 2' do
		post '/appointments',
		{ appointment:
			{first_name: 'Ed', last_name: 'Gonzo', start_time:'5:00', end_time: '6:00', day: '3000',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 422, response.status
		assert_equal Mime::JSON, response.content_type
	end

	test 'creates appointment with time shortcut' do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'5', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type
		appointment = json(response.body)
		assert_equal appointment_url(appointment[:id]), response.location
	end

	test 'creates appointment with time shortcut 2'  do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'5pm', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type


		appointment = json(response.body)
		assert_equal appointment_url(appointment[:id]), response.location
	end
	test 'creates appointment with time shortcut 3'  do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'10:00', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type

		appointment = json(response.body)
		assert_equal appointment_url(appointment[:id]), response.location
	end

	test 'creates appointment with time shortcut 4'  do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'5:00pm', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type
		appointment = json(response.body)
		assert_equal appointment_url(appointment[:id]), response.location
	end

	test 'creates appointment with time shortcut 5'  do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'10:00pm', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type
		puts response.body
		appointment = json(response.body)
		assert_equal appointment_url(appointment[:id]), response.location
	end

	test 'cant create appointments with same time'  do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'10:00pm', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'10:00pm', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}
		assert_equal 422, response.status
		assert_equal Mime::JSON, response.content_type
	end

end



