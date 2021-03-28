class Tracker < ApplicationRecord
  PLATFORMS = Set['android', 'ios', 'windows', 'mac', 'linux'].freeze
  belongs_to :url
  scope :with_platform, ->(platform) { where("platform = ?", platform)}
  validates :url_id, presence: true
  validates :platform, presence: true, inclusion: { in: PLATFORMS + ['other'] }
end
