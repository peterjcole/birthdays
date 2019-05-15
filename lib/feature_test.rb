require_relative 'birthday_list'
list = BirthdayList.new
list.store('Peter', '1994-04-25')
list.list
puts list.formatted_list
list.store('Jim', '2018-05-15')
puts list.birthdays_today