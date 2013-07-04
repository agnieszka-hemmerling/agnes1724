require 'mechanize'
require './schema.rb'


#agent = Mechanize.new
#agent.user_agent_alias = 'Linux Firefox'
#agent.get('http://en.wikipedia.org/wiki/List_of_horse_breeds') do |page|
#  page.parser.css('table.multicol li').each do |li|
#    if li.css('a')
#      name = li.css('a').text
#      HorseBreed.create(:name => name)
#    end
#    if tr.css('td')[6]
#      puts tr.css('td').css('img').attr('src')
#    end
#  end
#end
agent = Mechanize.new
agent.user_agent_alias = 'Linux Firefox'
agent.get('http://en.wikipedia.org/wiki/List_of_horse_breeds') do |page|
  page.parser.css('table.multicol li').each do |li|
    if li.css('a')
      name = li.css('a').text
      puts name
#      Breed.create(:name => name)
    end
#    if tr.css('td')[6]
#      puts tr.css('td').css('img').attr('src')
#    end
  end
end
