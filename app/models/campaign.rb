class Campaign < ApplicationRecord
  # BUG 1: removed desc - default not required
  validates :name, presence: true, length: { maximum: 100 }

  # BUG 2: has_many. Not has_one + cascade
  has_many :tasks, dependent: :destroy

  # BUG 3: Added default
  enum status: [:active, :completed, :archived], _default: :active
end