module JPCalendar
  module Create 

    def self.first_week(first_date)
      res = []
      7.times do |wday|
        target = first_date - first_date.wday + wday
        css_class = target.wday == 0 ? 'td_holiday' : 'td_day'
        css_class += first_date.wday > target.wday ? '_unactive' : ''
        res.push([css_class, target.mday])
      end
      res
    end
    
    def self.last_week(last_date)
      res = []
      7.times do |wday|
        target = last_date - last_date.wday + wday
        css_class = target.wday == 0 ? 'td_holiday' : 'td_day'
        css_class += last_date.wday < target.wday ? '_unactive' : ''
        res.push([css_class, target.mday])
      end
      res
    end
    
    def self.other_weeks(first_date, last_date)
      res = []
      tmp_res = []
      start  = (first_date + 7 - first_date.wday)
      finish = (last_date - last_date.wday)
      Array.new(finish.mday - start.mday) {|i| i}.each do |cnt|
        target = start + cnt
        css_class = ''
        if target.wday == 0
          css_class = 'td_holiday'
          if tmp_res != []
            res.push(tmp_res)
            tmp_res = []
          end
        else
          css_class = 'td_day'
        end
        
        tmp_res.push([css_class, target.mday])
      end
      
      res.push(tmp_res)
      res
    end
  end
end
