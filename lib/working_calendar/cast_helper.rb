class WorkingCalendar
  module CastHelper

    DAY_NAMES = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    
    def cast_date(date)
      case 
        when date.is_a?(Date) then date
        when date.respond_to?(:to_date) then date.to_date
        when date.is_a?(String) then Date.parse(date)
        else raise(ArgumentError, "Invalid date #{date}")
      end
    end

    def cast_day_name(day_name)
      normalized_day_name = day_name.downcase.to_sym
      if DAY_NAMES.include? normalized_day_name
        normalized_day_name
      else
        raise ArgumentError, "Invalid day name #{day_name}"
      end
    end

    def cast_hours_ranges(hours_ranges)
      hours_ranges.each_with_object({}) do |(from_expression, to_expression), hash|
        from = Timing::HourMinutesSeconds.parse from_expression
        to = Timing::HourMinutesSeconds.parse to_expression
        raise ArgumentError, "Invalid range #{from - to}" if from >= to
        hash[from] = to
      end
    end

  end
end