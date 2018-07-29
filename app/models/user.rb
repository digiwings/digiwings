class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :generate_skydemon_key
  has_many :logs

  validates :skydemon_key, uniqueness: true

  private

  def generate_skydemon_key
    self.skydemon_key = SecureRandom.hex[0..8] unless skydemon_key
  end
  
end
