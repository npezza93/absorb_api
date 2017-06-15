# frozen_string_literal: true

module AbsorbApi
  class SessionSchedule < Record
    attr_accessor :id, :session_id, :venue_id, :venue_type, :venue_name,
                  :date_start, :date_end, :time_zone_id, :meeting_id,
                  :meeting_username, :meeting_password
  end
end
