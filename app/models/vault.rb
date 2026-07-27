class Vault < ApplicationRecord
  belongs_to :user

  validates :site, presence: true
  validates :url, presence: true
  validates :login, presence: true
  validates :password, presence: true
end