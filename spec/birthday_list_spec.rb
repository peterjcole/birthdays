require 'birthday_list'
require 'date'

describe BirthdayList do
  
  let(:birthday_list) { BirthdayList.new }
  let(:random_name) { ['John', 'Dave', 'Alex', 'Sam'].sample }
  let(:random_birthday) { ['1990-01-01', '2020-02-28', '2019-05-14', '2000-02-20'].sample }
  let(:second_random_name) { ['John', 'Dave', 'Alex', 'Sam'].sample }
  let(:second_random_birthday) { ['1990-01-01', '2020-02-28', '2019-05-14', '2000-02-20'].sample }
  let(:today) { Date.today.strftime("%Y-%m-%d") }
  let(:year_ago) do 
    today = Date.today
    year = (today.year - 1)
    month = today.mon
    day = today.mday
    return Date.new(year, month, day).strftime("%Y-%m-%d")
  end

  it 'should be able to be instantiated' do
    expect(birthday_list).to be_a(BirthdayList)
  end

  context 'when storing birthdays' do
    it 'should respond to .store' do
      expect(birthday_list).to respond_to(:store).with(2).arguments
    end

    it 'should return the birthday which has been stored' do
      expect(birthday_list.store(random_name, random_birthday)).to eq([random_name, random_birthday])
    end
  end

  context 'when listing birthdays' do
    it 'should respond to .list' do
      expect(birthday_list).to respond_to(:list)
    end

    it 'should return an empty array' do
      expect(birthday_list.list).to eq([])
    end
  end

  context 'when storing, then listing, birthdays' do
    it 'should store and list a single birthday' do
      birthday_list.store(random_name, random_birthday)
      expect(birthday_list.list).to eq([[random_name, random_birthday]])
    end

    it 'should store and list two birthdays' do
      birthday_list.store(random_name, random_birthday)
      birthday_list.store(second_random_name, second_random_birthday)
      expected_result = [[random_name, random_birthday], [second_random_name, second_random_birthday]]
      expect(birthday_list.list).to eq(expected_result)
    end
  end

  context 'when viewing birthdays in a tidy format' do
    it 'responds to .formatted_list' do
      expect(birthday_list).to respond_to(:formatted_list)
    end

    it 'returns a string' do
      expect(birthday_list.formatted_list).to be_a(String)
    end

    it 'returns a string of stored birthdays, once per line' do
      birthday_list.store(random_name, random_birthday)
      birthday_list.store(second_random_name, second_random_birthday)
      expected_result = "Here's a list of birthdays!\n#{random_name} - #{random_birthday}\n#{second_random_name} - #{second_random_birthday}"
      expect(birthday_list.formatted_list).to eq(expected_result)
    end
  end

  context 'checking whose birthday it is today' do
    it 'responds to birthdays_today' do
      expect(birthday_list).to respond_to(:birthdays_today)
    end

    it 'returns a string' do
      expect(birthday_list.birthdays_today).to be_a(String)
    end

    it 'returns the name of a person who was born today' do
      birthday_list.store(random_name, today)
      expect(birthday_list.birthdays_today).to eq("Here's the birthdays for today!\nIt's #{random_name}'s birthday today! #{random_name} is 0 years old!")
    end

    it 'returns the names of two people who were born today' do
      birthday_list.store(random_name, today)
      birthday_list.store(second_random_name, today)
      expect(birthday_list.birthdays_today).to eq("Here's the birthdays for today!\nIt's #{random_name}'s birthday today! #{random_name} is 0 years old!\nIt's #{second_random_name}'s birthday today! #{second_random_name} is 0 years old!")
    end

    it 'returns a nice message if there are no birthdays today' do
      expect(birthday_list.birthdays_today).to eq("It's noone's birthday today :(")
    end

    it 'returns the name and age of someone whos birthday was a year ago' do
      birthday_list.store(random_name, year_ago)
      expect(birthday_list.birthdays_today).to eq("Here's the birthdays for today!\nIt's #{random_name}'s birthday today! #{random_name} is 1 years old!")
    end 
  end
end