class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validate :validate_name_not_including_comma

  belongs_to :user
  has_one_attached :image

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "updated_at", "user_id"]
  end

  private

  def validate_name_not_including_comma
    errors.add(:name, "にカンマを含めることはできません") if name&.include?(",")
  end
end
