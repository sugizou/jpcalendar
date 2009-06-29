module JPCalendar
  class Create 
    
    attr_accessor :options, :datetime
    
    def initialize(options = { })
      options = { } unless options.class == Hash
      @options = options
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
        res.push([css_id, target.mday])
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
          if tmp_res != []
            res.push(tmp_res)
            tmp_res = []
          end
        else
          css_id = 'td_day'
        end
        
        tmp_res.push([css_id, target.mday])
      end
      
      res.push(tmp_res)
      res
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
  end
end
