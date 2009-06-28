#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../../lib/jpcalendar/template'


describe "Template" do
  
  describe '定数BASEは' do
    it '空およびnilではない' do
      JPCalendar::Template::BASE.should_not be_nil
      JPCalendar::Template::BASE.should_not == ''
    end
  end
  
  describe '定数HEADERは' do 
    it '空およびnilではない' do 
      JPCalendar::Template::HEADER.should_not be_nil
      JPCalendar::Template::HEADER.should_not == ''
    end
  end
  
  describe '定数MENUは' do 
    it '空およびnilではない' do 
      JPCalendar::Template::MENU.should_not be_nil
      JPCalendar::Template::MENU.should_not == ''
    end
  end
  
  describe '定数WEEKは' do 
    it '空およびnilではない' do 
      JPCalendar::Template::WEEK.should_not be_nil
      JPCalendar::Template::WEEK.should_not == ''
    end
  end
  
  describe '定数DAYは' do 
    it '空およびnilではない' do 
      JPCalendar::Template::DAY.should_not be_nil
      JPCalendar::Template::DAY.should_not == ''
    end
  end
  
  describe "定数LINKは" do 
    it '空およびnilではない' do 
      JPCalendar::Template::LINK.should_not be_nil
      JPCalendar::Template::LINK.should_not == ''
    end
  end
  
  describe '定数CSSは' do 
      it '空およびnilではない' do 
        JPCalendar::Template::CSS.should_not be_nil
        JPCalendar::Template::CSS.should_not == ''
      end
    end
    
    describe '定数CALENDAR_WEEKNAMESは' do 
      it '空およびnilではない' do 
        JPCalendar::Template::CALENDAR_WEEKNAMES.should_not be_nil
        JPCalendar::Template::CALENDAR_WEEKNAMES.should_not == ''
      end
      
      it 'arrayであり、要素は7つである' do 
        JPCalendar::Template::CALENDAR_WEEKNAMES.class.should == Array
        JPCalendar::Template::CALENDAR_WEEKNAMES.size == 7
      end
      
      it '各要素の中身は英語(略称)、英語(フル)、日本語(略称)、日本語(フル)の曜日名が入ったarray' do
        JPCalendar::Template::CALENDAR_WEEKNAMES[0].should == ['Sun','Sunday','日','日曜日']
        JPCalendar::Template::CALENDAR_WEEKNAMES[1].should == ['Mon','Monday','月','月曜日']
        JPCalendar::Template::CALENDAR_WEEKNAMES[2].should == ['Tue','Tuesday','火','火曜日']
        JPCalendar::Template::CALENDAR_WEEKNAMES[3].should == ['Wed','Wednesday','水','水曜日']
        JPCalendar::Template::CALENDAR_WEEKNAMES[4].should == ['Thu','Thursday','木','木曜日']
        JPCalendar::Template::CALENDAR_WEEKNAMES[5].should == ['Fri','Friday','金','金曜日']
        JPCalendar::Template::CALENDAR_WEEKNAMES[6].should == ['Sat','Saturday','土','土曜日']
      end
    end
  end
