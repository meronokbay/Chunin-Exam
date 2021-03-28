module UrlsHelper
  def visits_count(url)
    {
      total: url.trackers.count,
      android: url.trackers.with_platform('android').count,
      ios: url.trackers.with_platform('ios').count,
      windows: url.trackers.with_platform('windows').count,
      mac: url.trackers.with_platform('mac').count,
      linux: url.trackers.with_platform('linux').count,
      other: url.trackers.with_platform('other').count,
    }
  end
end
