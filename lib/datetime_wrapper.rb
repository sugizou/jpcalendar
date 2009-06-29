require 'date'

class DateTimeWrapper < DateTime
  
  def self.parse(date)
    if /^\d{4}(\-|\/)?\d{2}/ =~ date
      sep = $1.nil? ? '' : $1
      date += sep + '01'
    end
    super(date)
  end
  
  def ymd(sep = '')
    self.strftime("%Y#{sep}%m#{sep}%d")
  end
  
  def hms(sep = '')
    self.strftime("%H#{sep}%M#{sep}%S")
  end

  def ym(sep = '')
    self.strftime("%Y#{sep}%m")
  end
  
  def datetime(date_sep = '', time_sep = '')
    if (date_sep.nil? || date_sep == '')  && (time_sep.nil? || time_sep == '')
      return self.ymd + self.hms
    else
      return self.ymd(date_sep) + ' ' + self.hms(time_sep)
    end
  end
  
  def self.first
    obj = DateTimeWrapper.now
    obj = obj - obj.mday + 1
    DateTimeWrapper.parse(obj.ymd('-'))
  end
  
  def self.last
    obj = DateTimeWrapper.now
    obj = obj - obj.mday + 1
    DateTimeWrapper.parse(((obj >> 1) - 1).ymd('-'))
  end
end

