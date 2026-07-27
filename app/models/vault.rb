class Vault < ApplicationRecord
  belongs_to :user

  validates :site, presence: true
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :login, presence: true
  validates :password, presence: true
end