class State < ActiveRecord::Base

  #tables:
    # addresses
    # states
    # users

    # addresses
      #
    # states
      # name

  def self.top_states
    select("states.name, COUNT(*) AS no_of_users")
    .joins("JOIN addresses ON addresses.state_id = states.id")
    .joins("JOIN users ON addresses.user_id = users.billing_id")
    .group("states.name")
    .order("no_of_users DESC")
    .limit(3)   
  end

end
