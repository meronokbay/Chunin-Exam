class Tracker < ApplicationRecord
  PLATFORMS = Set['android', 'ios', 'windows', 'mac', 'linux'].freeze
  belongs_to :url
  scope :with_platform, ->(platform) { where("platform = ?", platform)}
end
