class Product < ActiveRecord::Base

  def self.find_all_in(from, to)
    Order.where(:created_at => from..to)
  end

end
