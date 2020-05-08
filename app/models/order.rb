class Order < ApplicationRecord
  validates :child_name, presence: true
  validates :thread_color, presence: true
  validates :font_name, presence: true
  validate :validate_name_not_including_comma

  belongs_to :user

  private

  def validate_name_not_including_comma
    errors.add(:child_name, 'にカンマを含めることはできません') if child_name&.include?(',')
  end
end
