class Task < ApplicationRecord
  belongs_to :campaign
  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :assigned_to, class_name: 'User', optional: true

  
  validates :title, presence: true, length: { maximum: 200 }

  enum status: [:todo, :in_progress, :done], _default: :todo
  enum priority: [:low, :medium, :high], _default: :medium

end
