class Guest < User

  def self.icon
    'fa-user'
  end

  def self.model_name
    User.model_name
  end

end