class Task < ApplicationRecord
  belongs_to :campaign
  
  validates :title, presence: true, length: { maximum: 200 }

  enum status: [:todo, :in_progress, :done], _default: :todo
  enum priority: [:low, :medium, :high], _default: :medium

end
