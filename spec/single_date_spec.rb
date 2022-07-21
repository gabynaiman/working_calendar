require 'minitest_helper'

describe WorkingCalendar::SingleDate do

  let(:moment) { Timing::NaturalTimeLanguage.parse '2018-11-04T14:27:00-06:00' }

  describe 'Included moments' do

    it 'Single hours range' do
      date = WorkingCalendar::SingleDate.new '2018-11-04', '09:00' => '18:00'
      assert date.include?(moment)
    end

    it 'Multiple hours ranges' do
      date = WorkingCalendar::SingleDate.new '2018-11-04', '09:00' => '13:00',
                                                           '14:00' => '18:00'
      assert date.include?(moment)
    end

  end

  describe 'Not included moments' do

    describe 'Single hours range' do

      it 'Same date and different time' do
        date = WorkingCalendar::SingleDate.new '2018-11-04', '17:00' => '20:00'
        refute date.include?(moment)
      end

      it 'Valid time and different date' do
        date = WorkingCalendar::SingleDate.new '2018-11-02', '09:00' => '20:00'
        refute date.include?(moment)
      end

    end

    describe 'Multiple hours ranges' do

      it 'Same date and different time' do
        date = WorkingCalendar::SingleDate.new '2018-11-04', '09:00' => '14:00',
                                                             '15:00' => '18:00'
        refute date.include?(moment)
      end

      it 'Valid time and different date' do
        date = WorkingCalendar::SingleDate.new '2018-11-02', '09:00' => '13:00',
                                                             '14:00' => '18:00'
        refute date.include?(moment)
      end

    end

  end

  it 'To string' do
    assert_equal '2018-11-04 {09:00:00=>18:00:00}', WorkingCalendar::SingleDate.new('2018-11-04', '09:00' => '18:00').to_s
  end

  describe 'Cast date' do

    it 'Date' do
      working_date = WorkingCalendar::SingleDate.new(Date.parse('2018-11-04'), '09:00' => '18:00')
      assert_equal Date.parse('2018-11-04'), working_date.date
    end

    it 'Time' do
      working_date = WorkingCalendar::SingleDate.new(Time.parse('2018-11-04'), '09:00' => '18:00')
      assert_equal Date.parse('2018-11-04'), working_date.date
    end

    it 'Invalid date' do
      error = proc { WorkingCalendar::SingleDate.new 123, '09:00' => '18:00' }.must_raise ArgumentError
      assert_equal 'Invalid date 123', error.message
    end

    it 'Invalid range' do
      error = proc { WorkingCalendar::SingleDate.new(Time.parse('2018-11-04'), '10:00' => '09:00') }.must_raise ArgumentError
      assert_equal 'Invalid range 10:00:00 - 09:00:00', error.message
    end

  end

end