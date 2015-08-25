Date::DATE_FORMATS.merge!(
  db: "%Y-%m-%d",
  friendly: "%b %d",
  :tz => '%Z',
  :mdy  => "%m/%d/%Y",
)

Time::DATE_FORMATS.merge!(
  :just_time => '%l:%M %p',
  :with_tz => '%l:%M %p %Z',
  :tz => '%Z',
  :mdy  => "%m/%d/%Y",
  :ymd  => "%Y-%m-%d",
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %H:%M",
  :js  => "new Date(%Y, %m, %d, %H, %M)"
)