class Room < ApplicationRecord

  belongs_to :user

  has_many :reservations
  has_many :photos
  has_one_attached :avatar
  has_many_attached :photos
  has_many_attached :images

  validates :room_type, presence: true
  validates :summary, presence: true
  validates :price, presence: true
  validates :address, presence: true

  def room
    if self.images.attached?
      self.images.first
    end
  end

  def self.ransackable_associations(auth_object = nil)
    ["images", "reservations", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "room_type", "summary"]
  end
end
