class Chef < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :recipes, autosave: true

  validates :chefname, presence: true, length: { maximum: 30 }
  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false },
      length: { maximum: 255 },
      email: true
  validates_acceptance_of :privacy_policy
end
