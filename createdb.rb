# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :specials, text: true
  String :date
  String :location
  String :address
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going

end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "St. Patty’s Day Bar Review", 
                    specials: "All-you-can-drink wristbands for $20, raffle tickets for a $50 and $100 Duffy’s Gift Card ($5 for 3 or $10 for 10). Note that these must be purchased at the SFPIF table in the atrium between 3/2 and 3/12",
                    date: "Thursday, March 12th from 9pm – 1 am",
                    location: "Duffy’s Tavern",
                    address: "420 W Diversey Pkwy, Chicago, IL, 60614")

events_table.insert(title: "JD / MBA Bar Review @ the Concrete Cowboy", 
                    specials: "1/2 off all apps, $3 draft beers, buy one, get one whiskey shots",
                    date: "Thursday, March 26th from 8:30pm – 2 am",
                    location: "The Concrete Cowboy",
                    address: "646 North Franklin Street, Chicago, IL, 60654")

events_table.insert(title: "BLSA Bar Review", 
                    specials: "Half priced bottles of wine, $5 well cocktails, $15 fish bowls",
                    date: "Thursday, April 2nd from 10pm – 1:30 am",
                    location: "Sheffield's Chicago",
                    address: "3258 North Sheffield Avenue, Chicago, IL 60657")                    
