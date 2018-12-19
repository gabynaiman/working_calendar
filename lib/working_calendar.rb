require 'date'
require 'timing'
require 'multi_require'

MultiRequire.require_relative_pattern 'working_calendar/*'

class WorkingCalendar

  attr_reader :zone_offset, :working_week_days, :working_dates, :not_working_week_days, :not_working_dates

  def initialize(zone_offset)
    @zone_offset = Timing::ZoneOffset.parse zone_offset
    @working_week_days = []
    @working_dates = []
    @not_working_week_days = []
    @not_working_dates = []
  end

  def add_working_week_day(day_name, hours_ranges)
    working_week_days << WeekDay.new(day_name, hours_ranges)
  end

  def add_working_date(date, hours_ranges)
    working_dates << SingleDate.new(date, hours_ranges)
  end

  def add_not_working_week_day(day_name, hours_ranges)
    not_working_week_days << WeekDay.new(day_name, hours_ranges)
  end

  def add_not_working_date(date, hours_ranges)
    not_working_dates << SingleDate.new(date, hours_ranges)
  end

  def working_at?(time)
    time_in_zone = Timing::TimeInZone.new(time).to_zone(zone_offset)

    (working_week_days | working_dates).any? { |e| e.include? time_in_zone } &&
    !(not_working_week_days | not_working_dates).any? { |e| e.include? time_in_zone }
  end

end