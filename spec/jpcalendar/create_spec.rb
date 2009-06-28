#!/usr/bin/env ruby
require 'date'
require File.dirname(__FILE__) + '/../../lib/jpcalendar/create'

describe JPCalendar::Create do
  
  describe "self.first_weekメソッドは" do
    it "cssのid名と日付がセットになった二次元配列を返す。2009年6月" do
      first_date = Date.parse('2009-06-01')      
      first_week = JPCalendar::Create.first_week(first_date)
      first_week[0].should == ['td_holiday_unactive', 31]
      first_week[1].should == ['td_day', 1]
      first_week[2].should == ['td_day', 2]
      first_week[3].should == ['td_day', 3]
      first_week[4].should == ['td_day', 4]
      first_week[5].should == ['td_day', 5]
      first_week[6].should == ['td_day', 6]
    end
    
    it "2009年7月" do 
      first_date = Date.parse('2009-07-01')
      first_week = JPCalendar::Create.first_week(first_date)
      first_week[0].should == ['td_holiday_unactive', 28]
      first_week[1].should == ['td_day_unactive', 29]
      first_week[2].should == ['td_day_unactive', 30]
      first_week[3].should == ['td_day', 1]
      first_week[4].should == ['td_day', 2]
      first_week[5].should == ['td_day', 3]
      first_week[6].should == ['td_day', 4]
    end 
    
    it "2009年11月" do
      first_date = Date.parse('2009-11-01')
      first_week = JPCalendar::Create.first_week(first_date)
      first_week[0].should == ['td_holiday', 1]
      first_week[1].should == ['td_day', 2]
      first_week[2].should == ['td_day', 3]
      first_week[3].should == ['td_day', 4]
      first_week[4].should == ['td_day', 5]
      first_week[5].should == ['td_day', 6]
      first_week[6].should == ['td_day', 7]
    end
    
  end
  
  describe "self.last_weekメソッドは" do 
    
    it "cssのid名と日付がセットになった二次元配列を返す。2009年6月" do 
      last_date = Date.parse('2009-06-30')
      last_week = JPCalendar::Create.last_week(last_date)
      last_week[0].should == ['td_holiday', 28]
      last_week[1].should == ['td_day', 29]
      last_week[2].should == ['td_day', 30]
      last_week[3].should == ['td_day_unactive', 1]
      last_week[4].should == ['td_day_unactive', 2]
      last_week[5].should == ['td_day_unactive', 3]
      last_week[6].should == ['td_day_unactive', 4]
      
    end

    it "2009年7月" do
      last_date = Date.parse('2009-07-31')
      last_week = JPCalendar::Create.last_week(last_date)
      last_week[0].should == ['td_holiday', 26]
      last_week[1].should == ['td_day', 27]
      last_week[2].should == ['td_day', 28]
      last_week[3].should == ['td_day', 29]
      last_week[4].should == ['td_day', 30]
      last_week[5].should == ['td_day', 31]
      last_week[6].should == ['td_day_unactive', 1]
    end
    
    it "2009年10月" do
      last_date = Date.parse('2009-10-31')
      last_week = JPCalendar::Create.last_week(last_date)
      last_week[0].should == ['td_holiday', 25]
      last_week[1].should == ['td_day', 26]
      last_week[2].should == ['td_day', 27]
      last_week[3].should == ['td_day', 28]
      last_week[4].should == ['td_day', 29]
      last_week[5].should == ['td_day', 30]
      last_week[6].should == ['td_day', 31]
    end

  end

  describe "self.other_weeksメソッドは" do 

    it "最初と最後の週以外の週情報をcssのidと日付のセットで三次元配列で返す。2009年6月" do
      first_date = Date.parse('2009-06-01')
      last_date  = Date.parse('2009-06-30')
      
      other_weeks = JPCalendar::Create.other_weeks(first_date, last_date)
      other_weeks[0][0].should == ['td_holiday', 7]
      other_weeks[0][1].should == ['td_day', 8]
      other_weeks[0][2].should == ['td_day', 9]
      other_weeks[0][3].should == ['td_day', 10]
      other_weeks[0][4].should == ['td_day', 11]
      other_weeks[0][5].should == ['td_day', 12]
      other_weeks[0][6].should == ['td_day', 13]

      other_weeks[1][0].should == ['td_holiday', 14]
      other_weeks[1][1].should == ['td_day', 15]
      other_weeks[1][2].should == ['td_day', 16]
      other_weeks[1][3].should == ['td_day', 17]
      other_weeks[1][4].should == ['td_day', 18]
      other_weeks[1][5].should == ['td_day', 19]
      other_weeks[1][6].should == ['td_day', 20]

      other_weeks[2][0].should == ['td_holiday', 21]
      other_weeks[2][1].should == ['td_day', 22]
      other_weeks[2][2].should == ['td_day', 23]
      other_weeks[2][3].should == ['td_day', 24]
      other_weeks[2][4].should == ['td_day', 25]
      other_weeks[2][5].should == ['td_day', 26]
      other_weeks[2][6].should == ['td_day', 27]

    end
    
    it "2009年7月" do 
      first_date = Date.parse('2009-07-01')
      last_date  = Date.parse('2009-07-31')
      
      other_weeks = JPCalendar::Create.other_weeks(first_date, last_date)
      other_weeks[0][0].should == ['td_holiday', 5]
      other_weeks[0][1].should == ['td_day', 6]
      other_weeks[0][2].should == ['td_day', 7]
      other_weeks[0][3].should == ['td_day', 8]
      other_weeks[0][4].should == ['td_day', 9]
      other_weeks[0][5].should == ['td_day', 10]
      other_weeks[0][6].should == ['td_day', 11]

      other_weeks[1][0].should == ['td_holiday', 12]
      other_weeks[1][1].should == ['td_day', 13]
      other_weeks[1][2].should == ['td_day', 14]
      other_weeks[1][3].should == ['td_day', 15]
      other_weeks[1][4].should == ['td_day', 16]
      other_weeks[1][5].should == ['td_day', 17]
      other_weeks[1][6].should == ['td_day', 18]

      other_weeks[2][0].should == ['td_holiday', 19]
      other_weeks[2][1].should == ['td_day', 20]
      other_weeks[2][2].should == ['td_day', 21]
      other_weeks[2][3].should == ['td_day', 22]
      other_weeks[2][4].should == ['td_day', 23]
      other_weeks[2][5].should == ['td_day', 24]
      other_weeks[2][6].should == ['td_day', 25]
    end
  end
  
  describe "header" do 
  end
  
end
