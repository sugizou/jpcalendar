#!/usr/bin/env ruby
require 'date'
require File.dirname(__FILE__) + '/../../lib/jpcalendar/create'
require File.dirname(__FILE__) + '/../../lib/datetime_wrapper'

describe JPCalendar::Create do

  before(:all) do 
    @create = JPCalendar::Create.new({ })
  end
  
  describe "first_weekメソッドは" do
    it "cssのid名と日付がセットになった二次元配列を返す。2009年6月" do
      first_date = DateTimeWrapper.parse('2009-06-01')      
      first_week = @create.first_week(first_date)
      first_week[0].should == ['td_holiday_unactive', 31]
      first_week[1].should == ['td_day', 1]
      first_week[2].should == ['td_day', 2]
      first_week[3].should == ['td_day', 3]
      first_week[4].should == ['td_day', 4]
      first_week[5].should == ['td_day', 5]
      first_week[6].should == ['td_day', 6]
    end
    
    it "2009年7月" do 
      first_date = DateTimeWrapper.parse('2009-07-01')
      first_week = @create.first_week(first_date)
      first_week[0].should == ['td_holiday_unactive', 28]
      first_week[1].should == ['td_day_unactive', 29]
      first_week[2].should == ['td_day_unactive', 30]
      first_week[3].should == ['td_day', 1]
      first_week[4].should == ['td_day', 2]
      first_week[5].should == ['td_day', 3]
      first_week[6].should == ['td_day', 4]
    end 
    
    it "2009年11月" do
      first_date = DateTimeWrapper.parse('2009-11-01')
      first_week = @create.first_week(first_date)
      first_week[0].should == ['td_holiday', 1]
      first_week[1].should == ['td_day', 2]
      first_week[2].should == ['td_day', 3]
      first_week[3].should == ['td_day', 4]
      first_week[4].should == ['td_day', 5]
      first_week[5].should == ['td_day', 6]
      first_week[6].should == ['td_day', 7]
    end
    
    describe "optionsにmodelとmethodが指定されている場合" do 
      it "その値を見て一致すればリンクを張る" do 
        class SampleModel
          attr_accessor :created_at
          
          def initialize(date)
            @created_at = date
          end
        end
        
        models = ['2009-05-20','2009-05-31','2009-06-02', '2009-06-09'].map{|d| SampleModel.new(DateTime.parse(d)) }
        
        first_date = DateTimeWrapper.parse('2009-06-01')
        @create = JPCalendar::Create.new(:model => models, :method => :created_at)
        first_week = @create.first_week(first_date)
        
        first_week[0].should == ['td_holiday_unactive', '<a href="?created_at=20090531">31</a>']
        first_week[1].should == ['td_day', 1]
        first_week[2].should == ['td_day', '<a href="?created_at=20090602">2</a>']
        first_week[3].should == ['td_day', 3]
        first_week[4].should == ['td_day', 4]
        first_week[5].should == ['td_day', 5]
        first_week[6].should == ['td_day', 6]
      end
    end
    
    describe "optionsにmarkersが指定されている場合" do 
      it "指定された日のcssのid名を変える" do 
        markers = [Date.parse('2009-06-01')]
        
        first_date = DateTimeWrapper.parse('2009-06-01')
        @create = JPCalendar::Create.new(:markers => markers)
        first_week = @create.first_week(first_date)
        first_week[0].should == ['td_holiday_unactive', 31]
        first_week[1].should == ['td_day_mark', 1]
        first_week[2].should == ['td_day', 2]
        first_week[3].should == ['td_day', 3]
        first_week[4].should == ['td_day', 4]
        first_week[5].should == ['td_day', 5]
        first_week[6].should == ['td_day', 6]
      end
      
      it "複数渡された場合、複数id名を変える" do 
        markers = [Date.parse('2009-06-01'), Date.parse('2009-06-02'), Date.parse('2009-06-03')]
        
        first_date = DateTimeWrapper.parse('2009-06-01')
        @create = JPCalendar::Create.new(:markers => markers)
        first_week = @create.first_week(first_date)
        first_week[0].should == ['td_holiday_unactive', 31]
        first_week[1].should == ['td_day_mark', 1]
        first_week[2].should == ['td_day_mark', 2]
        first_week[3].should == ['td_day_mark', 3]
        first_week[4].should == ['td_day', 4]
        first_week[5].should == ['td_day', 5]
        first_week[6].should == ['td_day', 6]
      end
    end
  end
  
  describe "last_weekメソッドは" do 
    
    it "cssのid名と日付がセットになった二次元配列を返す。2009年6月" do 
      last_date = Date.parse('2009-06-30')
      last_week = @create.last_week(last_date)
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
      last_week = @create.last_week(last_date)
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
      last_week = @create.last_week(last_date)
      last_week[0].should == ['td_holiday', 25]
      last_week[1].should == ['td_day', 26]
      last_week[2].should == ['td_day', 27]
      last_week[3].should == ['td_day', 28]
      last_week[4].should == ['td_day', 29]
      last_week[5].should == ['td_day', 30]
      last_week[6].should == ['td_day', 31]
    end

  end

  describe "other_weeksメソッドは" do 

    it "最初と最後の週以外の週情報をcssのidと日付のセットで三次元配列で返す。2009年6月" do
      first_date = Date.parse('2009-06-01')
      last_date  = Date.parse('2009-06-30')
      
      other_weeks = @create.other_weeks(first_date, last_date)
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
      
      other_weeks = @create.other_weeks(first_date, last_date)
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
