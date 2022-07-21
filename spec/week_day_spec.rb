require 'minitest_helper'

describe WorkingCalendar::WeekDay do

  let(:moment) { Timing::NaturalTimeLanguage.parse '2018-11-04T14:27:00-06:00' }

  describe 'Included moments' do

    it 'Single hours range' do
      week_day = WorkingCalendar::WeekDay.new :sunday, '09:00' => '18:00'
      assert week_day.include?(moment)
    end

    it 'Multiple hours ranges' do
      week_day = WorkingCalendar::WeekDay.new :sunday, '09:00' => '13:00',
                                                       '14:00' => '18:00'
      assert week_day.include?(moment)

    end

  end

  describe 'Not included moments' do

    describe 'Single hours range' do

      it 'Same week day and different time' do
        week_day = WorkingCalendar::WeekDay.new :sunday, '17:00' => '20:00'
        refute week_day.include?(moment)
      end

      it 'Valid time and different week day' do
        week_day = WorkingCalendar::WeekDay.new :monday, '09:00' => '20:00'
        refute week_day.include?(moment)
      end

    end

    describe 'Multiple hours ranges' do

      it 'Same week day and different time' do
        week_day = WorkingCalendar::WeekDay.new :sunday, '09:00' => '14:00',
                                                         '15:00' => '18:00'
        refute week_day.include?(moment)
      end
      
      it 'Valid time and different week day' do
        week_day = WorkingCalendar::WeekDay.new :monday, '09:00' => '13:00',
                                                         '14:00' => '18:00'
        refute week_day.include?(moment)
      end

    end

  end

  it 'To string' do
    assert_equal 'Tuesday {09:00:00=>18:00:00}', WorkingCalendar::WeekDay.new(:tuesday, '09:00' => '18:00').to_s
  end

  it 'Invalid day name' do
    error = proc { WorkingCalendar::WeekDay.new :xyz, '09:00' => '18:00' }.must_raise ArgumentError
    assert_equal 'Invalid day name xyz', error.message
  end

  it 'Invalid range' do
    error = proc { WorkingCalendar::WeekDay.new :sunday, '18:00' => '09:00' }.must_raise ArgumentError
    assert_equal 'Invalid range 18:00:00 - 09:00:00', error.message
  end

end