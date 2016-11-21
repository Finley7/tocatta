class User < ActiveRecord::Base

  has_secure_password

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }, :format => { :with => /\A(?=.*[a-z])[a-z\d]+\Z/i }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  has_one :role, :foreign_key => :id, :primary_key => :primary_role
  has_many :topics, :foreign_key => :author_id

  has_and_belongs_to_many :roles

  def has_role(id)
    roles = Rolesuser.where(:user_id => self.id, :role_id => id).first

    if roles.nil?
      false
    else
      true
    end
  end



end
