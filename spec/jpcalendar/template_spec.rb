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
    
    describe '定数WEEKNAMESは' do 
      it '空およびnilではない' do 
        JPCalendar::Template::WEEKNAMES.should_not be_nil
        JPCalendar::Template::WEEKNAMES.should_not == ''
      end
      
      it 'arrayであり、要素は7つである' do 
        JPCalendar::Template::WEEKNAMES.class.should == Array
        JPCalendar::Template::WEEKNAMES.size == 7
      end
      
      it '各要素の中身は英語(略称)、英語(フル)、日本語(略称)、日本語(フル)の曜日名が入ったarray' do
        JPCalendar::Template::WEEKNAMES[0].should == ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
        JPCalendar::Template::WEEKNAMES[1].should == ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
        JPCalendar::Template::WEEKNAMES[2].should == ['日', '月', '火', '水', '木', '金',  '土']
        JPCalendar::Template::WEEKNAMES[3].should == ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日']
      end
    end
  end
