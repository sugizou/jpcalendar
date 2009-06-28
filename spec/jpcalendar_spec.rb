#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../lib/jpcalendar'

describe JPCalendar do
  describe 'create_calendarメソッドは' do 
    it "年月ごとにカレンダーを生成する" do 
      JPCalendar.create_calendar(Date.today).should_not be_nil
    end
    
  end
end
