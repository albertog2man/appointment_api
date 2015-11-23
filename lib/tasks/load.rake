namespace :load do
  desc "TODO"
  task data: :environment do 
  	require 'json'
	csv = SmarterCSV.process('./appt_data.csv')

	hash = csv[62]

	def arrange(time)
		month = time[0..1]
		day = time[3..4]

		time[0..1] = day
		time[3..4] = month
		return time
	end


	def get_time(time)
		time = arrange(time)
		t = Time.parse(time)
		t = t.strftime('%r')
		t[-6..-3] = ''
		t = t[0..4]+ t[-2..-1].downcase
		return t
	end

	def get_month(time)
		t = Time.parse(time)
		t = t.strftime('%B')
		return t
	end

	def get_day(time)
		t = Time.parse(time)
		t = t.strftime('%d')
		return t
	end

	def get_year(time)
		t = Time.parse(time)
		t = t.strftime('%G')
		return t
	end
	# t = get_time(start_time)
	# puts t
		start_time = get_time(hash[:start_time])
		p start_time
		end_time = get_time(hash[:end_time])
		p end_time
		first_name = hash[:first_name]
		p first_name
		last_name = hash[:last_name]
		p last_name
		month = get_month(hash[:start_time])
		p month
		day = get_day(hash[:start_time])
		p day
		year = get_year(hash[:start_time])
		p year
	# counter = 0
	# csv.each do |hash|
	# 	start_time = get_time(hash[:start_time])
	# 	end_time = get_time(hash[:end_time])
	# 	first_name = hash[:first_name]
	# 	last_name = hash[:last_name]
	# 	month = get_month(hash[:start_time])
	# 	day = get_day(hash[:start_time])
	# 	year = get_year(hash[:start_time])

	# 	appointment = Appointment.create!(
	# 		start_time: start_time, 
	# 		end_time: end_time, 
	# 		month: month, 
	# 		day: day, 
	# 		year: year, 
	# 		first_name: first_name,
	# 		last_name: last_name
	# 		)
	# end
	message = { appointment:
			{first_name: 'Bill', last_name: 'Gonzo', start_time:'10:00pm', end_time: '6:00', day: '13',month: '12', year: '2015'}
		}
	# message = { 'appointment' => { 'start_time' => start_time, 'end_time' => end_time, 'month' => month, 'day' => day, 'year' => year, 'first_name' => first_name, 'last_name' => last_name}}
	puts message.to_json
	`curl -v https://guarded-fjord-3968.herokuapp.com/appointments -X POST -H 'Content-Type:application/json' -H 'Accept:application/json'  -d "#{message.to_json}"`

	end
end
