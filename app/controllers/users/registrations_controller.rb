class Users::RegistrationsController < Devise::RegistrationsController
	def create
		puts "RIGHT CONTROLLER"
		super do |resource|
			puts "resource"
			puts resource.to_s
		end
	end
end