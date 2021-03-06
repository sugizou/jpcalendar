#!/usr/bin/env ruby
require 'date'
require File.dirname(__FILE__) + '/../../lib/jpcalendar/create'
require File.dirname(__FILE__) + '/../../lib/datetime_wrapper'

describe JPCalendar::Create do

  before(:all) do 
    @create = JPCalendar::Create.new({ })
  end
  
  describe "baseメソッドは" do 
    it "カレンダーのベースデータを生成する(first_week,last_weekと処理が違いますが同期は取れてます。いずれfirst_week(),last_week(),other_weeks()は消す予定です)" do
      date = DateTimeWrapper.parse('2009-06-30')
      bases = @create.base(date)
      bases[0][0].should == ['td_holiday_unactive', 31]
      bases[0][1].should == ['td_day', 1]
      bases[0][2].should == ['td_day', 2]
      bases[0][3].should == ['td_day', 3]
      bases[0][4].should == ['td_day', 4]
      bases[0][5].should == ['td_day', 5]
      bases[0][6].should == ['td_day', 6]

      bases[1][0].should == ['td_holiday', 7]
      bases[1][1].should == ['td_day', 8]
      bases[1][2].should == ['td_day', 9]
      bases[1][3].should == ['td_day', 10]
      bases[1][4].should == ['td_day', 11]
      bases[1][5].should == ['td_day', 12]
      bases[1][6].should == ['td_day', 13]

      bases[2][0].should == ['td_holiday', 14]
      bases[2][1].should == ['td_day', 15]
      bases[2][2].should == ['td_day', 16]
      bases[2][3].should == ['td_day', 17]
      bases[2][4].should == ['td_day', 18]
      bases[2][5].should == ['td_day', 19]
      bases[2][6].should == ['td_day', 20]

      bases[3][0].should == ['td_holiday', 21]
      bases[3][1].should == ['td_day', 22]
      bases[3][2].should == ['td_day', 23]
      bases[3][3].should == ['td_day', 24]
      bases[3][4].should == ['td_day', 25]
      bases[3][5].should == ['td_day', 26]
      bases[3][6].should == ['td_day', 27]

      bases[4][0].should == ['td_holiday', 28]
      bases[4][1].should == ['td_day', 29]
      bases[4][2].should == ['td_day', 30]
      bases[4][3].should == ['td_day_unactive', 1]
      bases[4][4].should == ['td_day_unactive', 2]
      bases[4][5].should == ['td_day_unactive', 3]
      bases[4][6].should == ['td_day_unactive', 4]
    end
    
    it "String/Fixnum/Date/DateTimeオブジェクトの引数にも対応している" do
      @create.base('2009-06-01').should == @create.base(DateTimeWrapper.parse('2009-06-01'))
      @create.base(20090601).should == @create.base(DateTimeWrapper.parse('2009-06-01'))
      @create.base(Date.parse('2009-06-01')).should == @create.base(DateTimeWrapper.parse('2009-06-01'))
      @create.base(DateTime.parse('2009-06-01')).should == @create.base(DateTimeWrapper.parse('2009-06-01'))
    end
    
    it "first_week(),last_wekk(),other_weeks()と同期が取れてるかのテスト" do 
      date = DateTimeWrapper.now
      first = date.first
      last  = date.last
      @create.base(date).should == @create.other_weeks(first,last).unshift(@create.first_week(first)).push(@create.last_week(last))
    end
    
    describe "optionsにmodelとmethodが指定されている場合" do 
      it "その値を見て一致すればリンクを張る" do 
        class SampleModel
          attr_accessor :created_at
          
          def initialize(date)
            @created_at = date
          end
        end
        
        models = ['2009-05-20','2009-05-31','2009-06-02', '2009-06-18', '2009-06-28'].map{|d| SampleModel.new(DateTime.parse(d)) }
        @create = JPCalendar::Create.new(:model => models, :method => :created_at)

        bases = @create.base('2009-06-12')
        bases[0][0].should == ['td_holiday_unactive', '<a href="?created_at=20090531">31</a>']
        bases[0][1].should == ['td_day', 1]
        bases[0][2].should == ['td_day', '<a href="?created_at=20090602">2</a>']
        bases[0][3].should == ['td_day', 3]
        bases[0][4].should == ['td_day', 4]
        bases[0][5].should == ['td_day', 5]
        bases[0][6].should == ['td_day', 6]
        
        bases[2][0].should == ['td_holiday', 14]
        bases[2][1].should == ['td_day', 15]
        bases[2][2].should == ['td_day', 16]
        bases[2][3].should == ['td_day', 17]
        bases[2][4].should == ['td_day', '<a href="?created_at=20090618">18</a>']
        bases[2][5].should == ['td_day', 19]
        bases[2][6].should == ['td_day', 20]

        bases[4][0].should == ['td_holiday', '<a href="?created_at=20090628">28</a>']
        bases[4][1].should == ['td_day', 29]
        bases[4][2].should == ['td_day', 30]
        bases[4][3].should == ['td_day_unactive', 1]
        bases[4][4].should == ['td_day_unactive', 2]
        bases[4][5].should == ['td_day_unactive', 3]
        bases[4][6].should == ['td_day_unactive', 4]
      end
    end
    
    describe "optionsにmarkersが指定されている場合" do 
      it "指定された日のcssのid名を変える" do 
        markers = [Date.parse('2009-06-29')]
        @create = JPCalendar::Create.new(:markers => markers)
        bases   = @create.base(DateTimeWrapper.parse('2009-06-12'))
        
        bases[4][0].should == ['td_holiday', 28]
        bases[4][1].should == ['td_day_mark', 29]
        bases[4][2].should == ['td_day', 30]
        bases[4][3].should == ['td_day_unactive', 1]
        bases[4][4].should == ['td_day_unactive', 2]
        bases[4][5].should == ['td_day_unactive', 3]
        bases[4][6].should == ['td_day_unactive', 4]
      end
    end
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

    describe "optionsにmodelとmethodが指定されている場合" do 
      it "その値を見て一致すればリンクを張る" do 
        class SampleModel
          attr_accessor :created_at
          
          def initialize(date)
            @created_at = date
          end
        end
        
        models = ['2009-06-27','2009-06-30','2009-07-03', '2009-07-05'].map{|d| SampleModel.new(DateTime.parse(d)) }
        
        last_date = DateTimeWrapper.parse('2009-06-30')
        @create = JPCalendar::Create.new(:model => models, :method => :created_at)
        last_week = @create.last_week(last_date)
        
        last_week[0].should == ['td_holiday', 28]
        last_week[1].should == ['td_day', 29]
        last_week[2].should == ['td_day', '<a href="?created_at=20090630">30</a>']
        last_week[3].should == ['td_day_unactive', 1]
        last_week[4].should == ['td_day_unactive', 2]
        last_week[5].should == ['td_day_unactive', '<a href="?created_at=20090703">3</a>']
        last_week[6].should == ['td_day_unactive', 4]
      end
    end
    
    describe "optionsにmarkersが指定されている場合" do 
      it "指定された日のcssのid名を変える" do 
        markers = [Date.parse('2009-06-29')]
        
        last_date = DateTimeWrapper.parse('2009-06-30')
        @create = JPCalendar::Create.new(:markers => markers)
        last_week = @create.last_week(last_date)
        last_week[0].should == ['td_holiday', 28]
        last_week[1].should == ['td_day_mark',29]
        last_week[2].should == ['td_day', 30]
        last_week[3].should == ['td_day_unactive', 1]
        last_week[4].should == ['td_day_unactive', 2]
        last_week[5].should == ['td_day_unactive', 3]
        last_week[6].should == ['td_day_unactive', 4]
      end
      
      it "複数渡された場合、複数id名を変える" do 
        markers = [Date.parse('2009-06-28'), Date.parse('2009-06-30'), Date.parse('2009-07-02')]
        
        last_date = DateTimeWrapper.parse('2009-06-30')
        @create = JPCalendar::Create.new(:markers => markers)
        last_week = @create.last_week(last_date)
        last_week[0].should == ['td_day_mark', 28]
        last_week[1].should == ['td_day', 29]
        last_week[2].should == ['td_day_mark', 30]
        last_week[3].should == ['td_day_unactive', 1]
        last_week[4].should == ['td_day_mark', 2]
        last_week[5].should == ['td_day_unactive', 3]
        last_week[6].should == ['td_day_unactive', 4]
      end
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

    describe "optionsにmodelとmethodが指定されている場合" do 
      it "その値を見て一致すればリンクを張る" do 
        class SampleModel
          attr_accessor :created_at
          
          def initialize(date)
            @created_at = date
          end
        end
        
        models = ['2009-06-05', '2009-06-11', '2009-06-14', '2009-06-22', '2009-06-27'].map{|d| SampleModel.new(DateTime.parse(d)) }
        
        first_date = DateTimeWrapper.parse('2009-06-01')
        last_date = DateTimeWrapper.parse('2009-06-30')

        @create = JPCalendar::Create.new(:model => models, :method => :created_at)
        other_weeks = @create.other_weeks(first_date, last_date)
        
        other_weeks[0][0].should == ['td_holiday', 7]
        other_weeks[0][1].should == ['td_day', 8]
        other_weeks[0][2].should == ['td_day', 9]
        other_weeks[0][3].should == ['td_day', 10]
        other_weeks[0][4].should == ['td_day', '<a href="?created_at=20090611">11</a>']
        other_weeks[0][5].should == ['td_day', 12]
        other_weeks[0][6].should == ['td_day', 13]
        
        other_weeks[1][0].should == ['td_holiday', '<a href="?created_at=20090614">14</a>']
        other_weeks[1][1].should == ['td_day', 15]
        other_weeks[1][2].should == ['td_day', 16]
        other_weeks[1][3].should == ['td_day', 17]
        other_weeks[1][4].should == ['td_day', 18]
        other_weeks[1][5].should == ['td_day', 19]
        other_weeks[1][6].should == ['td_day', 20]
        
        other_weeks[2][0].should == ['td_holiday', 21]
        other_weeks[2][1].should == ['td_day', '<a href="?created_at=20090622">22</a>']
        other_weeks[2][2].should == ['td_day', 23]
        other_weeks[2][3].should == ['td_day', 24]
        other_weeks[2][4].should == ['td_day', 25]
        other_weeks[2][5].should == ['td_day', 26]
        other_weeks[2][6].should == ['td_day', '<a href="?created_at=20090627">27</a>']
      end
    end
    
    describe "optionsにmarkersが指定されている場合" do 
      it "指定された日のcssのid名を変える" do 
        markers = [Date.parse('2009-07-10'), Date.parse('2009-07-12'), Date.parse('2009-07-20'), Date.parse('2009-07-25')]
        
        first_date = DateTimeWrapper.parse('2009-07-01')
        last_date = DateTimeWrapper.parse('2009-07-31')

        @create = JPCalendar::Create.new(:markers => markers)
        other_weeks = @create.other_weeks(first_date, last_date)
        
        other_weeks[0][0].should == ['td_holiday', 5]
        other_weeks[0][1].should == ['td_day', 6]
        other_weeks[0][2].should == ['td_day', 7]
        other_weeks[0][3].should == ['td_day', 8]
        other_weeks[0][4].should == ['td_day', 9]
        other_weeks[0][5].should == ['td_day_mark', 10]
        other_weeks[0][6].should == ['td_day', 11]
        
        other_weeks[1][0].should == ['td_day_mark', 12]
        other_weeks[1][1].should == ['td_day', 13]
        other_weeks[1][2].should == ['td_day', 14]
        other_weeks[1][3].should == ['td_day', 15]
        other_weeks[1][4].should == ['td_day', 16]
        other_weeks[1][5].should == ['td_day', 17]
        other_weeks[1][6].should == ['td_day', 18]
        
        other_weeks[2][0].should == ['td_holiday', 19]
        other_weeks[2][1].should == ['td_day_mark', 20]
        other_weeks[2][2].should == ['td_day', 21]
        other_weeks[2][3].should == ['td_day', 22]
        other_weeks[2][4].should == ['td_day', 23]
        other_weeks[2][5].should == ['td_day', 24]
        other_weeks[2][6].should == ['td_day_mark', 25]
      end
    end
  end
  
  describe "menubarメソッドは" do
    
    before(:all) do 
      @date = DateTimeWrapper.now
    end
    
    it "デフォルトでカレンダー上部に表示される先月/今月/来月の表示とリンクに必要なデータを配列で返す" do 
      @create.menubar(@date).should == [
                                       "<a href=\"?date=#{(@date << 1).ym('-')}\">#{(@date << 1).ym('/')}</a>",
                                       @date.ym('/'),
                                       "<a href=\"?date=#{(@date >> 1).ym('-')}\">#{(@date >> 1).ym('/')}</a>"
                                      ]
    end
    
    describe "optionsがあるとき" do 
      it "prev_str,current_str,next_strは前の月/今月/次の月の表示文字を変更できる" do 
        @create = JPCalendar::Create.new(:prev_str => '先月', :next_str => '来月', :current_str => '今月')
        @create.menubar(@date).should == [
                                         "<a href=\"?date=#{(@date << 1).ym('-')}\">先月</a>",
                                         '今月',
                                         "<a href=\"?date=#{(@date >> 1).ym('-')}\">来月</a>"
                                        ]
      end
      
      it "prev_href,next_hrefは前の月/次の月のリンクにくっつけるクエリパラメータ。key => valセットのハッシュ" do 
        @create = JPCalendar::Create.new(
                                         :prev_href => { :created_at => (@date << 1).ym('/') },
                                         :next_href => { :created_at => (@date >> 1).ym('/') }
                                         )

        @create.menubar(@date).should == [
                                         "<a href=\"?created_at=#{(@date << 1).ym('/')}\">#{(@date << 1).ym('/')}</a>",
                                         @date.ym('/'),
                                          "<a href=\"?created_at=#{(@date >> 1).ym('/')}\">#{(@date >> 1).ym('/')}</a>"
                                        ]
      end
      
      it "other_paramsは前の月/次の月につけるその他のパラメータ。key => valセットのハッシュ" do 
        @create = JPCalendar::Create.new(
                                         :other_params => { 
                                           :hoge => 1,
                                         }
                                         )
        
        @create.menubar(@date).should == [
                                          "<a href=\"?date=#{(@date << 1).ym('-')}&hoge=1\">#{(@date << 1).ym('/')}</a>",
                                          @date.ym('/'),
                                          "<a href=\"?date=#{(@date >> 1).ym('-')}&hoge=1\">#{(@date >> 1).ym('/')}</a>",
                                         ]
      end
    end
  end
end
