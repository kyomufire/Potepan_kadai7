class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :trip

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_guests, presence: true, numericality: { greater_than: 0 }
  validate :start_end_check



  def start_end_check
      if self.start_date.present? && self.end_date.present?
          errors.add(:end_date, "は開始日より前の日付は登録できません。") unless
          self.start_date <= self.end_date
      end
  end

  def total_price
    if end_date.present? && end_date.present? && room.price? && number_of_guests?
      (end_date.to_date - start_date.to_date).to_i * room.price * number_of_guests
    else
      0
    end
  end

end