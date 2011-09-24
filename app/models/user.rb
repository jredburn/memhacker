class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  validates_presence_of :password, :on => :create
  
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end

