class AppointmentPatchTest < ActionDispatch::IntegrationTest
	setup {@appointment = Appointment.create!(
		first_name: 'Bill',last_name: 'Gonzo',start_time: '6:00',end_time: '7:00', day: '13',month: '12', year: '2015'
		)}

	test 'successfully updated' do
		patch "/appointments/#{@appointment.id}",
		{ appointment: {start_time: '5:00'}}.to_json,
		{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}

		assert_equal 200, response.status
		assert_equal '5:00', @appointment.reload.start_time
	end
end