require 'test_helper'

class AppointmentTests < ActionDispatch::IntegrationTest

	test 'list of all appointments' do
		get '/appointments'
		assert_equal 200, response.status
	end
end