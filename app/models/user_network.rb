class UserNetwork < ActiveRecord::Base
  	belongs_to :user, dependent: :destroy
	belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
	belongs_to :blockd, class_name: 'User', foreign_key: 'friend_id'
	# attr_accessor :user, :friend, :user_id, :friend_id, :state

	after_destroy :delete_mutual_network!

	state_machine :state, initial: :pending do 

		after_transition on: :accept, do: [:accept_mutual_network!]

		after_transition on: :block, do: [:block_mutual_network!]

		after_transition on: :unblock, do: [:accept_mutual_network!]

		state :requested
		state :blocked

		event :accept do
			transition any => :accepted
		end

		event :block do
			transition any => :blocked
		end

		event :unblock do
			transition any => :accepted
		end
	end

	def self.request(user1, user2)
		transaction do
			# Rails.logger.info "user1 is #{user1.inspect}"
			# Rails.logger.info "user2 is #{user2.inspect}"
			network1 = UserNetwork.create!(user: user1, friend: user2, state: 'pending')
			# Rails.logger.info "network1 is #{network1.inspect}"

			network2 = UserNetwork.create!(user: user2, friend: user1, state: 'requested' )

			# network1.send_request_email
			# network1
	    end
	end



	def mutual_network
		self.class.where({user_id: friend_id, friend_id: user_id}).first
	end

	def send_request_email
		UserNotifier.friend_requested(id).deliver
	end

	def send_acceptance_email
		UserNotifier.friend_request_accepted(id).deliver
	end

	def accept_mutual_network!
		#Grab the mutual network and update the state without using the state machine so as not to invoke callbacks
		mutual_network.update_attribute(:state, 'accepted')
	end

	def block_mutual_network!
		mutual_network.update_attribute(:state, 'blocked') if mutual_network
	end

	def delete_mutual_network!
		mutual_network.delete
	end
end
