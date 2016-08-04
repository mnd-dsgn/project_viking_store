class Order < ActiveRecord::Base
  class << self
    def find_all_in(from, to)
      where(:checkout_date => from..to).count
    end

    # def find_ave_value
    #   select("AVG(products.price * order_contents.quantity) AS order_total")
    #   .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
    #   .joins("JOIN products ON (products.id = order_contents.product_id)").where.not("orders.checkout_date IS NOT NULL")[0].order_total.round(2)
    # end

    def find_ave_value(from = nil, to = nil)
      ave = select("AVG(products.price * order_contents.quantity) AS order_total")
      .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
      .joins("JOIN products ON (products.id = order_contents.product_id)")

      if from && to
        ave.where("orders.checkout_date": from..to)[0].order_total.round(2)
      else
        ave[0].order_total.round(2)
      end
    end

    def find_max(from = nil, to = nil)
      max = select("MAX(products.price * order_contents.quantity) AS order_max")
      .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
      .joins("JOIN products ON (products.id = order_contents.product_id)")

      if from && to
        max.where("orders.checkout_date": from..to)[0].order_max
      else
        max[0].order_max
      end
    end

    def count
      where("checkout_date IS NOT NULL").count
    end

    # date, quantity, value, last 7 days

    def orders_by_day
      select("checkout_date, SUM(products.price * order_contents.quantity) AS day_total")
      .joins("JOIN order_contents ON (orders.id = order_contents.order_id)")
      .joins("JOIN products ON (products.id = order_contents.product_id)")
      .where("checkout_date IS NOT NULL")
      .group("checkout_date")
      .order("checkout_date DESC")[0..6]
    end

  end
end
