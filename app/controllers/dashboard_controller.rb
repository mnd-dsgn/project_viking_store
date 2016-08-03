class DashboardController < ApplicationController
  def index
    @totals = {"Total Users": User.count, "Total Orders": Order.count, "Total Products": Product.count, "Revenue": OrderContent.revenue}

    @last_thirty = {"New_Users": User.find_all_in(30.days.ago, DateTime.zone.current), "Orders placed": Order.count.where() , "New Products": , "Revenue": }

  end
end
