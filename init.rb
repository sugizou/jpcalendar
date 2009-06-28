require File.dirname(__FILE__) + '/lib/jpcalendar'
require File.dirname(__FILE__) + '/lib/datetime_wrapper'
require File.dirname(__FILE__) + '/lib/jpcalendar/template'
require File.dirname(__FILE__) + '/lib/jpcalendar/create'

require 'jpcalendar_helper'
ActionView::Base.send(:include, JPCalendarHelper)
