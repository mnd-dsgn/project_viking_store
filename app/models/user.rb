class User < ActiveRecord::Base

  def self.find_all_in(from, to)
    User.where(:created_at => from..to)
  end

end
