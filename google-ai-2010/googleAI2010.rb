# http://ai-contest.com/rankings.php?page=1
# Country list
# Language list
# Organization list
# Take the top n of each Language, sum (ranking and or score) to provide metric about the languages representation in the competition
# Could map or geocode
require 'rubygems'
require 'hpricot'
require 'open-uri'

1.upto(47){|i|

  doc=Hpricot(open("http://ai-contest.com/rankings.php?page=#{i}"))
  t=doc/'table[@class="leaderboard"]'

  (t/'tbody/tr').each{|r|
     ranking = (r/'/td[1]/').text 
     username = (r/'/td[2]/a/').text 
     country=((r/'/td[3]/a/img').first[:title]) 
     organization = (r/'/td[4]/a/').text 
     language = (r/'/td[5]/a/').text 
     score=(r/'/td[6]/').text 

     str="#{ranking};#{username};#{country};#{organization};#{language};#{score};"
   puts str

  }

}