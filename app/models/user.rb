class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # also removed :registerable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
