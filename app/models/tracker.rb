class Tracker < ApplicationRecord
  PLATFORMS = Set['android', 'ios', 'windows', 'mac', 'linux'].freeze
  belongs_to :url
end
