class OrderContent < ActiveRecord::Base
  class << self
    def revenue
      OrderContent.find_by_sql("SELECT SUM(order_revenues) AS total_revenue
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
        AS all_orders")[0].total_revenue
    end

    def revenue_period(from, to)
      OrderContent.select("orders.id, COUNT(*) AS order_totals").joins("JOIN products ON product_id = products.id").joins("JOIN orders ON order_id = orders.id").group("orders.id").where("orders.checkout_date": from..to)
    end
  end
end
