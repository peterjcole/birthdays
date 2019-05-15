require 'date'

class BirthdayList
  attr_reader :list
  def initialize
    @list = []
  end

  def store(name, birthday)
    person = { 
      name: name, 
      birthday: Date.parse(birthday)
    }
    @list.push(person)
    return person_to_arr(person)
  end

  def list
    arr = []
    @list.each { |person| arr.push(person_to_arr(person)) }
    return arr
  end

  def formatted_list
    @list.reduce("Here's a list of birthdays!") do |memo, person| 
      memo + "\n#{formatted_birthday(person)}"
    end
  end

  def birthdays_today
    birthdays = @list.filter do |person|
      person[:birthday].mon == Date.today.mon && person[:birthday].day == Date.today.day
    end
    return "It's noone's birthday today :(" unless birthdays.length > 0
    birthdays.reduce("Here's the birthdays for today!") do |memo, person|
      memo + "\n#{formatted_birthday_today(person)}"
    end
  end

  def formatted_birthday_today(person)
    return "It's #{person[:name]}'s birthday today! #{person[:name]} is #{age(person)} years old!"
  end

  def age(person)
    birthday = person[:birthday]
    now = Time.now.utc.to_date
    now.year - birthday.year
  end

  def formatted_birthday(person)
    return "#{person[:name]} - #{birthday_to_string(person[:birthday])}"
  end

  def person_to_arr(person)
    return [person[:name], birthday_to_string(person[:birthday])]
  end

  def birthday_to_string(birthday)
    birthday.strftime("%Y-%m-%d")
  end



end