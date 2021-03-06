class AppointmentDeleteTest < ActionDispatch::IntegrationTest
	setup {@appointment = Appointment.create!(
		first_name: 'Bill',last_name: 'Gonzo',start_time: '6:00',end_time: '7:00', day: '13',month: '12', year: '2015'
		)}

	test 'is deleting appointment' do
		delete "/appointments/#{@appointment.id}"
		assert_equal 204, response.status
	end
end
