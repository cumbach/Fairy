class Appointment < ActiveRecord::Base
	before_validation on: [:create] do
		self.scheduled_at = DateTime.now
	end
		
	validates :address, presence: true
	validates :scheduled_at, presence: true
	validates :start_at, presence: true
	validates :end_at, presence: true

	belongs_to :housekeeper

	def self.filter(curr)
	    sorted = Appointment.all.sort{|a,b| a.start_at <=> b.start_at}
	    sorted.select do |unbooked|
	    	curr.appointments.all? do |booking|
	    		!unbooked.start_at.between?(booking.start_at, booking.end_at) &&
	    		!unbooked.end_at.between?(booking.start_at, booking.end_at)
	    	end
	    end
  	end

end
