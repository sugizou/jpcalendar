require File.dirname(__FILE__) + '/../lib/datetime_wrapper'
require 'date'

describe DateTimeWrapper do   
    
  
  describe 'parseメソッドは' do 
    
    it 'DateTimeのparseとほぼ同機能' do 
      DateTimeWrapper.parse('2009-01-02').to_s.should == DateTime.parse('2009-01-02').to_s
      DateTimeWrapper.parse('2009-01-01 10:00:00+0900').to_s.should == DateTime.parse('2009-01-01 10:00:00+0900').to_s
      begin
        DateTimeWrapper.parse('2009')#parseできない
      rescue => ex
        ex.class.should == ArgumentError
      end
    end
    
    it 'DateTimeのparseで、年月しかない場合エラーにならないようになってる' do
      DateTimeWrapper.parse('2009-01').to_s.should == DateTime.parse('2009-01-01').to_s
    end
  end
  
  describe 'ymdメソッドは' do
    before(:all) do 
      @datetime = DateTimeWrapper.parse('2009-02-28 12:34:56+0900')
    end
    
    it 'yyymmddの形で返す' do
      @datetime.ymd.should == '20090228'
    end
    
    it '引数を渡すとその文字でセパレートされる' do 
      @datetime.ymd('-').should == '2009-02-28'
    end
  end
  
  describe 'ymメソッドは' do
    before(:all) do 
      @datetime = DateTimeWrapper.parse('2009-02-28 12:34:56+0900')
    end
    
    it 'yyyymmの形で返す' do 
      @datetime.ym.should == '200902'
    end
    
    it '引数を渡すとその文字でセパレートされる' do 
      @datetime.ym('/').should == '2009/02'
    end
  end
  
  describe 'hmsメソッドは' do 
    before(:all) do 
      @datetime = DateTimeWrapper.parse('2009-02-28 12:34:56+0900')
    end

    it 'HHMMSSの形で返す' do 
      @datetime.hms.should == '123456'
    end
    
    it '引数を渡すとその文字でセパレートされる' do 
      @datetime.hms(':').should == '12:34:56'
    end
  end
  
  describe 'datetimeメソッドは' do 
    before(:all) do 
      @datetime = DateTimeWrapper.parse('2009-02-28 12:34:56+0900')
    end

    it 'yyyymmddHHMMSSの形で返す' do
      @datetime.datetime.should == '20090228123456'
    end
    
    it '引数1を渡すと年月日、引数2を渡すと時分秒をセパレートする' do
      @datetime.datetime('/',':').should == '2009/02/28 12:34:56'
    end

    it "引数1,2のどちらも空文字またはnilだった場合は引数なしと同じ挙動" do 
      @datetime.datetime('', '').should == '20090228123456'
      @datetime.datetime(nil, '').should == '20090228123456'
      @datetime.datetime('', nil).should == '20090228123456'
      @datetime.datetime(nil, nil).should == '20090228123456'
    end
  end
  
  describe 'firstメソッドは' do 
    
    it 'その月の最初の年月日を返す' do 
      datetime = DateTime.parse(sprintf('%04d-%02d-%02d',DateTime.now.year, DateTime.now.month, 1))
      DateTimeWrapper.now.first.to_s.should == datetime.to_s
      DateTimeWrapper.now.first.ymd.to_s.should == datetime.strftime('%Y%m%d')
      DateTimeWrapper.now.first.datetime.to_s.should == datetime.strftime('%Y%m%d%H%M%S')
    end
  end
  
  describe 'lastメソッドは' do
    it 'その月の最後の年月日を返す' do 
      datetime = DateTime.parse(sprintf('%04d-%02d-%02d',DateTime.now.year, DateTime.now.month, 1))
      datetime = (datetime >> 1) - 1
      DateTimeWrapper.now.last.to_s == datetime.to_s
      DateTimeWrapper.now.last.ymd.to_s.should == datetime.strftime('%Y%m%d')
      DateTimeWrapper.now.last.datetime.to_s.should == datetime.strftime('%Y%m%d%H%M%S')
    end
  end
end
