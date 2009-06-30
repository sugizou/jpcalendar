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
  
  def first
    obj = self - self.mday + 1
    DateTimeWrapper.parse(sprintf('%04d-%02d-%02d', obj.year, obj.month, obj.mday))
  end
  
  def last
    obj = ((self - self.mday + 1) >>  1) - 1
    DateTimeWrapper.parse(sprintf('%04d-%02d-%02d', obj.year, obj.month, obj.mday))
  end
end

