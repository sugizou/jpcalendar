module JPCalendar
  class Create 
    
    attr_accessor :options
    
    def initialize(options = { })
      options = { } unless options.class == Hash
      @options = options
    end
    
    def base(date)
      date = replace_date_obj(date)
      first_date = date.first
      first_date = first_date - first_date.wday
      last_date  = date.last
      last_date  = last_date + (6 - last_date.wday)
      
      week = []
      month = []
      (last_date - first_date + 1).to_i.times do |cnt|
        target = first_date + cnt
        css  = target.wday == 0 ? 'td_holiday' : 'td_day'
        css += date.month != target.month ? '_unactive' : ''
        css = marker(target) || css
        day = anchor(target) || target.mday
        week.push([css, day])
        
        if target.wday % 7 == 6
          month.push(week)
          week = []
        end
      end
      return month
    end
    
    def first_week(first_date)
      res = []
      7.times do |wday|
        target = first_date - first_date.wday + wday
        css_id = target.wday == 0 ? 'td_holiday' : 'td_day'
        css_id += first_date.wday > target.wday ? '_unactive' : ''
        css_id = marker(target) || css_id
        day = anchor(target) || target.mday
        res.push([css_id, day])
      end
      res
    end
    
    def last_week(last_date)
      res = []
      7.times do |wday|
        target = last_date - last_date.wday + wday
        css_id = target.wday == 0 ? 'td_holiday' : 'td_day'
        css_id += last_date.wday < target.wday ? '_unactive' : ''
        css_id = marker(target) || css_id
        day = anchor(target) || target.mday
        res.push([css_id, day])
      end
      res
    end
    
    def other_weeks(first_date, last_date)
      res = []
      tmp_res = []
      start  = (first_date + 7 - first_date.wday)
      finish = (last_date - last_date.wday)
      Array.new(finish.mday - start.mday) {|i| i}.each do |cnt|
        target = start + cnt
        css_id = ''
        if target.wday == 0
          css_id = 'td_holiday'
          unless tmp_res.empty?
            res.push(tmp_res)
            tmp_res = []
          end
        else
          css_id = 'td_day'
        end
        css_id = marker(target) || css_id
        day    = anchor(target) || target.mday
        tmp_res.push([css_id, day])
      end
      
      res.push(tmp_res)
      res
    end

    def menubar(date)
      if date.class == String
        date = DateTimeWrapper.parse(date)
      end

      prev_str    = options[:prev_str] || (date << 1).ym('/')
      next_str    = options[:next_str] || (date >> 1).ym('/')
      current_str = options[:current_str] || date.ym('/')
      
      params      = options[:other_params] || { }
      prev_param  = options[:prev_href] || { :date => (date << 1).ym('-')}
      next_param  = options[:next_href] || { :date => (date >> 1).ym('-')}
      
      prev_href  = '?' + params.merge(prev_param).to_query
      next_href  = '?' + params.merge(next_param).to_query
      
      [sprintf(JPCalendar::Template::LINK, prev_href, prev_str), current_str, sprintf(JPCalendar::Template::LINK, next_href, next_str)]
    end

    private
    def anchor(date)
      if self.options[:model].nil? || self.options[:model].class != Array || self.options[:model].empty?
        return nil
      end

      if self.options[:method].nil? || self.options[:method] == ''
        return nil
      end

      if self.options[:model].map{|m| m.send(self.options[:method]).strftime('%Y%m%d')}.include?(date.ymd)
        return sprintf(JPCalendar::Template::LINK, "?#{options[:method].to_s}=#{date.ymd}", date.mday)
      else
        return nil
      end
    end
    
    def marker(date)
      if self.options[:markers].nil? || (self.options.class == Array && self.options.empty?)
        return nil
      end

      markers = self.options[:markers]
      if markers.class == Date || markers.class == DateTime
        markers = [markers]
      elsif markers.class == String
        markers = DateTimeWraper.parse(markers)
      end

      if markers.map{|m| m.strftime('%Y%m%d')}.include?(date.ymd)
        return 'td_day_mark'
      else
        return nil
      end
    end
    
    def replace_date_obj(date)
      if date.class == String || date.class == Fixnum
        return DateTimeWrapper.parse(date.to_s)
      elsif date.class == Date || date.class == DateTime
        return DateTimeWrapper.parse(date.to_s)
      elsif date.class == DateTimeWrapper
        return date
      end
    end
  end
end

class Hash
  def to_query
    param = []
    self.each do |key,val|
      param.push("#{key}=#{val}")
    end
    param.join('&')
  end
end
