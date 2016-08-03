class User < ActiveRecord::Base

  def self.find_all_in(from, to)
    User.where(:created_at => from..to).count
  end



# select("cities.name, COUNT(*) AS num_users").joins("JOIN addresses ON (users.billing_id = address.id)")

  def self.join_products_orders
    select("users.first_name, users.last_name, SUM(products.price * order_contents.quantity) AS order_total")
    .joins("JOIN orders ON (users.id = orders.user_id)")
    .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
    .joins("JOIN products ON (products.id = order_contents.product_id)")
    .group("users.first_name, users.last_name")
  end

end
