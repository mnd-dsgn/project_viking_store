class DashboardController < ApplicationController
  def index
    @total_users = User.count
    @total_orders = Order.count
    @total_products = Product.count

    @revenue = OrderContent.find_by_sql("SELECT SUM(order_revenues) AS total_revenue 
      FROM ( 
            SELECT o.id,
            SUM(products.price*order_contents.quantity) AS order_revenues
            FROM order_contents
            JOIN products ON product_id = products.id
            JOIN (SELECT * 
                  FROM orders 
                 WHERE checkout_date IS NOT NULL) 
              AS o ON order_id=o.id
            GROUP BY o.id) 
        AS all_orders")
  end
end
