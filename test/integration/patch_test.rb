class AppointmentPatchTest < ActionDispatch::IntegrationTest
	setup {@appointment = Appointment.create!(
		first_name: 'steven',last_name: 'little',start_time: '06:00pm',end_time: '07:00pm', day: '13',month: '12', year: '2015'
		)}

	test 'successfully updated' do
		patch "/appointments/#{@appointment.id}",
		{ appointment: {start_time: '5:00'}}.to_json,
		{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 200, response.status
		assert_equal '05:00pm', @appointment.reload.start_time
	end

	test 'successfully updated 2' do
		patch "/appointments/#{@appointment.id}",
		{ appointment: {start_time: '5'}}.to_json,
		{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 200, response.status
		assert_equal '05:00pm', @appointment.reload.start_time
	end

	test 'unsuccessfully updated' do
		patch "/appointments/#{@appointment.id}",
		{ appointment: {start_time: '0:00'}}.to_json,
		{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 422, response.status
	end
end