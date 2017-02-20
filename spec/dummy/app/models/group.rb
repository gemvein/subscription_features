class Group < ActiveRecord::Base
  paid_for scope: :active

  scope :active, -> { where(active: true) }
end
