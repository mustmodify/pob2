Date::DATE_FORMATS.merge!(
  default: "%m/%d/%Y",
  md: "%b %d",
  db: "%Y-%m-%d",
  friendly: "%A %m/%d",
  tz: '%Z',
  mdy: "%m/%d/%Y",
)

Time::DATE_FORMATS.merge!(
  :just_time => '%l:%M %p',
  :with_tz => '%l:%M %p %Z',
  :tz => '%Z',
  :md => "%b %d",
  :mdy  => "%m/%d/%Y",
  :ymd  => "%Y-%m-%d",
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %H:%M",
  :js  => "new Date(%Y, %m, %d, %H, %M)"
)
