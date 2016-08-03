class DashboardController < ApplicationController
  def index
    @total_users = User.count
    @total_orders = Order.count
    @total_products = Product.count
    # all the products from orders that have been placed multiplied by quantity in the order_contents table multiplied by unit price

    @revenue = 
    Order.joins(:order_contents).joins(:products)
  end
end
