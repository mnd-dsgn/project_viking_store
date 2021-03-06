class User < ActiveRecord::Base
  class << self
    def find_all_in(from, to)
      User.where(:created_at => from..to).count
    end


  # There is a table for our best customers which contains columns for the Criteria, Customer Name, and Quantity
  #
  # Field: Highest single order value and the customer who achieved it
  #
  # Field: Highest Lifetime value customer (by total revenue generated)
  #
  # Field: Highest average order value and the customer who placed it
  #
  # Field: Most orders placed and the customer who placed it

    def high_single_order
      join_users_products_orders.order("order_total DESC").group("order_id, users.first_name, users.last_name").limit(1)
    end

    def highest_lifetime_value
      join_users_products_orders.order("order_total DESC").group("users.first_name, users.last_name").limit(1)
    end

    def highest_average_order_value
      select("users.first_name, users.last_name, AVG(products.price * order_contents.quantity) AS order_ave")
      .joins("JOIN orders ON (users.id = orders.user_id)")
      .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
      .joins("JOIN products ON (products.id = order_contents.product_id)").group("users.first_name, users.last_name").order("order_ave DESC").limit(1)
    end


    def join_users_products_orders
      select("users.first_name, users.last_name, SUM(products.price * order_contents.quantity) AS order_total")
      .joins("JOIN orders ON (users.id = orders.user_id)")
      .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
      .joins("JOIN products ON (products.id = order_contents.product_id)")
    end


  end
end
