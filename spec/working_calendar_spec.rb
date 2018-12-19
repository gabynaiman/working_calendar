require 'minitest_helper'

describe WorkingCalendar do

  let :calendar do
    WorkingCalendar.new('-0600').tap do |calendar|
      calendar.add_working_week_day     :monday, '09:00' => '18:00'
      calendar.add_not_working_week_day :monday, '13:00' => '14:00'

      calendar.add_working_date     '2018-12-29', '10:00' => '14:00'
      calendar.add_not_working_date '2018-12-31', '10:00' => '14:00'
    end
  end

  describe 'Working' do

    it 'Week day' do
      assert calendar.working_at? Time.parse('2018-12-17T12:35:00-0600')
      assert calendar.working_at? Time.parse('2018-12-17T13:35:00-0500') # 12:35:00 -0600
    end

    it 'Date' do
      assert calendar.working_at? Time.parse('2018-12-29T12:35:00-0600')
      assert calendar.working_at? Time.parse('2018-12-29T16:35:00-0100') # 11:35:00 -0600
    end

  end

  describe 'Not working' do

    it 'Week day' do
      refute calendar.working_at? Time.parse('2018-12-17T13:35:00-0600')
      refute calendar.working_at? Time.parse('2018-12-17T12:35:00-0700') # 13:35:00 -0600
    end

    it 'Date' do
      refute calendar.working_at? Time.parse('2018-12-31T13:35:00-0600')
      refute calendar.working_at? Time.parse('2018-12-31T11:35:00-0700') # 12:35:00 -0600
    end

  end

end