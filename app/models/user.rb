class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  
  validates :encrypted_password,confirmation: true, presence: true
  validates_presence_of :full_name
  validates_presence_of :mobilenumber
  validates :email, presence: true
end
