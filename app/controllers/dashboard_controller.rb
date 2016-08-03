class DashboardController < ApplicationController
  def index
    @totals = {"Total Users": User.count, "Total Orders": Order.count, "Total Products": Product.count, "Revenue": OrderContent.revenue}

    @last_thirty = {"New_Users": User.find_all_in(30.days.ago, DateTime.current), "Orders placed": Order.find_all_in(30.days.ago, DateTime.current) , "New Products": Product.find_all_in(30.days.ago, DateTime.current), "Revenue": OrderContent.revenue_period(30.days.ago, DateTime.current)}

  end
end
