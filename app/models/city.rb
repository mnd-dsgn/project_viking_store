class City < ActiveRecord::Base

  def self.top_cities
    select("cities.name, COUNT(*) AS no_of_users")
    .joins("JOIN addresses ON addresses.city_id = cities.id")
    .joins("JOIN users ON addresses.user_id = users.billing_id")
    .group("cities.name")
    .order("no_of_users DESC")
    .limit(3)
  end

end
