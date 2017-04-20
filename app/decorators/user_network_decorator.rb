class UserNetworkDecorator < Draper::Decorator
  delegate_all

  decorates :user_network
  delegate_all

  def network_state
    model.state.titleize
  end

  def sub_message
    case model.state
    when 'pending'
      "Network request pending."
    when 'accepted'
      "You are a network member of #{model.friend.first_name}."
    end
  end

end
