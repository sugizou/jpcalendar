module JPCalendar
  class Template
    
    BASE =  '<iframe id="jpcalendar">
  <table id="jpcalendar">
    %s
    %s
    %s
    %s
  </table>
</iframe>
'    

    HEADER =  '    <tr>
      <th id="th_holiday">%s</th>
      <th id="th_day">%s</th>
      <th id="th_day">%s</th>
      <th id="th_day">%s</th>
      <th id="th_day">%s</th>
      <th id="th_day">%s</th>
      <th id="th_day">%s</th>
    </tr>
'
    MENU =  '      <tr>
        <td colspan="2" id="calendar_menu_prev">%s</td>
        <td colspan="3" id="calendar_menu_center">%s</td>
        <td colspan="2" id="calendar_menu_next">%s</td>
      </tr>
'
    
    WEEK = '<tr>%s</tr>
'
    
    DAY = '<td id="%s">%s</td>
'

    LINK = '<a href="%s">%s</a>'

    CSS = '<script type="css/text">
iframe #jpcalendar {
  width:200px;
}
table #jpcalendar {
  width: 200px;
}

td #calendar_menu_prev {
  text-align: left;
}

td #calendar_menu_center {
  text-align: center;
}

td #calendar_menu_next {
  text-align: right;
}

th #th_holiday {
}
th #th_day {
}
td #td_holiday {
}
td #td_holiday_unactive {
}
td #td_day {
}
td #td_day_unactive {
}
td #td_day_mark {
}
</script>
'
    
    WEEKNAMES = [
                 ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                 ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
                 ['日', '月', '火', '水', '木', '金',  '土'],
                 ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日']
                ]    
  end 
end
