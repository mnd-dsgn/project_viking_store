class DashboardController < ApplicationController
  def index
    @totals = {
      "Total Users": User.count,
      "Total Orders": Order.count,
      "Total Products": Product.count,
      "Revenue": OrderContent.revenue
    }

    @last_thirty = {
      "New_Users": User.find_all_in(30.days.ago, DateTime.current),
      "Orders placed": Order.find_all_in(30.days.ago, DateTime.current),
      "New Products": Product.find_all_in(30.days.ago, DateTime.current),
      "Revenue": OrderContent.revenue_period(30.days.ago, DateTime.current)
    }

    @last_seven = {
      "New_Users": User.find_all_in(7.days.ago, DateTime.current),
      "Orders placed": Order.find_all_in(7.days.ago, DateTime.current),
      "New Products": Product.find_all_in(7.days.ago, DateTime.current),
      "Revenue": OrderContent.revenue_period(7.days.ago, DateTime.current)
    }
    @top_states = {}
    @top_cities = {}
    State.top_states.each do |state|
      @top_states[state.name] = state.no_of_users
    end
    City.top_cities.each do |city|
      @top_cities[city.name] = city.no_of_users
    end







  end
end
