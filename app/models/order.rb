class Order < ActiveRecord::Base

  def self.find_all_in(from, to)
    Order.where(:checkout_date => from..to)
  end

end
