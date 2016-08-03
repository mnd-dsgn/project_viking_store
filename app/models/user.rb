class User < ActiveRecord::Base

  def find_all_in()
    User.all.where()
  end

end
