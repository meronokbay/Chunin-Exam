class Url < ApplicationRecord
  # url regex copied from https://urlregex.com/
  url_regex = %r{\A(?:(?:https?|ftp)://)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:/[^\s]*)?\z}i
  validates :full_url, presence: true, format: { with: url_regex }
  validates :url_digest, presence: true, uniqueness: true

  before_validation :digest_url

  has_many :trackers
  has_one :grouping
  has_one :url, through: :grouping

  private

  def digest_url
    self.url_digest = Digest::SHA256.hexdigest("#{Time.now}-#{rand}-#{full_url}")[0..6]
  end
end
