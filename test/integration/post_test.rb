class AppointmentPostTest < ActionDispatch::IntegrationTest
	test 'creates appointment' do
		post '/appointments',
		{ appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'5:00', end_time: '6:00'}
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
			{first_name: nil, last_name: 'Gonzo', start_time:'5:00', end_time: '6:00'}
		}.to_json,
		{'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 422, response.status
		assert_equal Mime::JSON, response.content_type
	end
end