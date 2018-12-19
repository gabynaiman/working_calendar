class WorkingCalendar
  class SingleDate

    include CastHelper

    attr_reader :date, :hours_ranges
    
    def initialize(date, hours_ranges)
      @date = cast_date date
      @hours_ranges = cast_hours_ranges hours_ranges
    end

    def include?(time)
      hms = Timing::HourMinutesSeconds.new time.hour, time.min, time.sec
      date == time.to_date && hours_ranges.any? { |from, to| hms.between? from, to }
    end

    def to_s
      "#{date.iso8601} #{hours_ranges}"
    end
    alias_method :inspect, :to_s

  end
end