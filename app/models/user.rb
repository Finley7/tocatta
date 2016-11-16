class User < ActiveRecord::Base

  has_secure_password

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  has_one :role, :foreign_key => :id, :primary_key => :primary_role
  has_many :topics, :foreign_key => :author_id

  def has_role(id)
    role = Role.find(id)

    if self.primary_role == role.id
      true
    else
      false
    end

  end



end
