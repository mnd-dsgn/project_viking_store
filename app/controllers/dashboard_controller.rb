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
    State.top_states.each do |state|
      @top_states[state.name] = state.no_of_users
    end

    @top_cities = {}
    City.top_cities.each do |city|
      @top_cities[city.name] = city.no_of_users
    end

    @top_users = {}

    def top_users
      User.high_single_order.each do |user|
        name = "#{user.first_name} #{user.last_name}"
        @top_users[name] = user.order_total
      end
      User.highest_lifetime_value.each do |user|
        name = "#{user.first_name} #{user.last_name}"
        @top_users[name] = user.order_total
      end
      User.highest_average_order_value.each do |user|
        name = "#{user.first_name} #{user.last_name}"
        @top_users[name] = user.order_ave
      end
    end
    top_users

    @total_stats = {
      "Total Orders": Order.count,
      "Revenue Generated" : OrderContent.revenue,
      "Average Order" : Order.find_ave_value
      "Largest Order Value": Order.find_max_value
    }








  end
end
