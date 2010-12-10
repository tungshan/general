# encoding: windows-1252
require File.expand_path('extension')
require 'nkf'

str =  "<td class=xl84 width=128 style='width:96pt'>GAS TEST, GAS EXT FOR (2) RTUS"
puts str.encoding
puts str
utf = str.encode("utf-8")
cstr = utf.custom_strip
puts utf.encoding
puts utf

puts NKF.guess(str)



str = "01/20/2006 15:15:15"
str = str[0, str.rindex('/')+1] + str[str.rindex('/')+3,2]
puts str
