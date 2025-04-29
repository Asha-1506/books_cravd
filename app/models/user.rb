class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  
  # Admin role methods
  def admin?
    admin
  end
  
  def make_admin!
    update!(admin: true)
  end
  
  def remove_admin!
    update!(admin: false)
  end
end
