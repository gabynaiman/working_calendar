class WorkingCalendar
  class WeekDay

    include CastHelper

    attr_reader :day_name, :hours_ranges

    def initialize(day_name, hours_ranges)
      @day_name = cast_day_name day_name
      @hours_ranges = cast_hours_ranges hours_ranges
    end

    def include?(time)
      hms = Timing::HourMinutesSeconds.new time.hour, time.min, time.sec
      time.public_send("#{day_name}?") && hours_ranges.any? { |from, to| hms.between? from, to }
    end

    def to_s
      "#{day_name.capitalize} #{hours_ranges}"
    end
    alias_method :inspect, :to_s

  end
end