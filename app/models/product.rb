class Product < ActiveRecord::Base

  def self.find_all_in(from, to)
    Product.where(:created_at => from..to).count
  end

end
