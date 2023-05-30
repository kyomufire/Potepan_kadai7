class User < ApplicationRecord

    has_many :rooms
    has_many :reservations
    has_one_attached :avatar

    def avatar_attached?
        avatar.attached?
    end

    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

    validates :full_name, presence: true, length: { maximum: 20 }
    validates :email, uniqueness: true

end