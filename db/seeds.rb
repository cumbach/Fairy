# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do |x|
	start = Faker::Time.forward(21)
	
	Appointment.create!([
		{
			address: Faker::Address.street_address, 
			start_at: start,
			end_at: start + 7200
		}
	])
end