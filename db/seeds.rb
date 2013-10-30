# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#=========== Begin Static Data. Needed in all Installations ===========#

# Begin States
State.create(name: "Alabama", abbreviation: "AL")
State.create(name: "Alaska", abbreviation: "AK")
State.create(name: "Arizona", abbreviation: "AZ")
State.create(name: "Arkansas", abbreviation: "AR")
State.create(name: "California", abbreviation: "CA")
State.create(name: "Colorado", abbreviation: "CO")
State.create(name: "Connecticut", abbreviation: "CT")
State.create(name: "Delaware", abbreviation: "DE")
State.create(name: "District of Columbia", abbreviation: "DC")
State.create(name: "Florida", abbreviation: "FL")
State.create(name: "Georgia", abbreviation: "GA")
State.create(name: "Hawaii", abbreviation: "HI")
State.create(name: "Idaho", abbreviation: "ID")
State.create(name: "Illinois", abbreviation: "IL")
State.create(name: "Indiana", abbreviation: "IN")
State.create(name: "Iowa", abbreviation: "IA")
State.create(name: "Kansas", abbreviation: "KS")
State.create(name: "Kentucky", abbreviation: "KY")
State.create(name: "Louisiana", abbreviation: "LA")
State.create(name: "Maine", abbreviation: "ME")
State.create(name: "Maryland", abbreviation: "MD")
State.create(name: "Massachusetts", abbreviation: "MA")
State.create(name: "Michigan", abbreviation: "MI")
State.create(name: "Minnesota", abbreviation: "MN")
State.create(name: "Mississippi", abbreviation: "MS")
State.create(name: "Missouri", abbreviation: "MO")
State.create(name: "Montana", abbreviation: "MT")
State.create(name: "Nebraska", abbreviation: "NE")
State.create(name: "Nevada", abbreviation: "NV")
State.create(name: "New Hampshire", abbreviation: "NH")
State.create(name: "New Jersey", abbreviation: "NJ")
State.create(name: "New Mexico", abbreviation: "NM")
State.create(name: "New York", abbreviation: "NY")
State.create(name: "North Carolina", abbreviation: "NC")
State.create(name: "North Dakota", abbreviation: "ND")
State.create(name: "Ohio", abbreviation: "OH")
State.create(name: "Oklahoma", abbreviation: "OK")
State.create(name: "Oregon", abbreviation: "OR")
State.create(name: "Pennsylvania", abbreviation: "PA")
State.create(name: "Puerto Rico", abbreviation: "PR")
State.create(name: "Rhode Island", abbreviation: "RI")
State.create(name: "South Carolina", abbreviation: "SC")
State.create(name: "South Dakota", abbreviation: "SD")
State.create(name: "Tennessee", abbreviation: "TN")
State.create(name: "Texas", abbreviation: "TX")
State.create(name: "Utah", abbreviation: "UT")
State.create(name: "Vermont", abbreviation: "VT")
State.create(name: "Virginia", abbreviation: "VA")
State.create(name: "Washington", abbreviation: "WA")
State.create(name: "West Virginia", abbreviation: "WV")
State.create(name: "Wisconsin", abbreviation: "WI")
State.create(name: "Wyoming", abbreviation: "WY")
# End States

# Begin Dioceses
Diocese.create(name: "Birmingham", full_name: "Diocese of Birmingham", state_id: 1)
Diocese.create(name: "Mobile", full_name: "Archdiocese of Mobile", state_id: 1)
Diocese.create(name: "Anchorage", full_name: "Archdiocese of Anchorage", state_id: 2)
Diocese.create(name: "Fairbanks", full_name: "Diocese of Fairbanks", state_id: 2)
Diocese.create(name: "Juneau", full_name: "Diocese of Juneau", state_id: 2)
Diocese.create(name: "Holy Protection of Mary", full_name: "Holy Protection of Mary Byzantine Catholic Eparchy of Phoenix", state_id: 3)
Diocese.create(name: "Phoenix", full_name: "Diocese of Phoenix", state_id: 3)
Diocese.create(name: "Tucson", full_name: "Diocese of Tucson", state_id: 3)
Diocese.create(name: "Little Rock", full_name: "Diocese of Little Rock", state_id: 4)
Diocese.create(name: "St. Peter the Apostle", full_name: "Chaldean Catholic Eparchy of St. Peter the Apostle", state_id: 5)
Diocese.create(name: "Fresno", full_name: "Diocese of Fresno", state_id: 5)
Diocese.create(name: "Los Angeles", full_name: "Archdiocese of Los Angeles", state_id: 5)
Diocese.create(name: "Monterey", full_name: "Diocese of Monterey", state_id: 5)
Diocese.create(name: "Oakland", full_name: "Diocese of Oakland", state_id: 5)
Diocese.create(name: "Orange", full_name: "Diocese of Orange", state_id: 5)
Diocese.create(name: "Sacramento", full_name: "Diocese of Sacramento", state_id: 5)
Diocese.create(name: "San Bernardino", full_name: "Diocese of San Bernardino", state_id: 5)
Diocese.create(name: "San Diego", full_name: "Diocese of San Diego", state_id: 5)
Diocese.create(name: "San Francisco", full_name: "Archdiocese of San Francisco", state_id: 5)
Diocese.create(name: "San Jose", full_name: "Diocese of San Jose", state_id: 5)
Diocese.create(name: "Santa Rosa", full_name: "Diocese of Santa Rosa", state_id: 5)
Diocese.create(name: "Stockton", full_name: "Diocese of Stockton", state_id: 5)
Diocese.create(name: "Colorado Springs", full_name: "Diocese of Colorado Springs", state_id: 6)
Diocese.create(name: "Denver", full_name: "Archdiocese of Denver", state_id: 6)
Diocese.create(name: "Pueblo", full_name: "Diocese of Pueblo", state_id: 6)
Diocese.create(name: "Bridgeport", full_name: "Diocese of Bridgeport", state_id: 7)
Diocese.create(name: "Hartford", full_name: "Archdiocese of Hartford", state_id: 7)
Diocese.create(name: "Norwich", full_name: "Diocese of Norwich", state_id: 7)
Diocese.create(name: "Stamford", full_name: "Ukrainian Catholic Eparchy of Stamford", state_id: 7)
Diocese.create(name: "Wilmington", full_name: "Diocese of Wilmington", state_id: 8)
Diocese.create(name: "The Military Services", full_name: "Archdiocese of the Military Services")
Diocese.create(name: "Washington", full_name: "Archdiocese of Washington")
Diocese.create(name: "Miami", full_name: "Archdiocese of Miami", state_id: 10)
Diocese.create(name: "Orlando", full_name: "Diocese of Orlando", state_id: 10)
Diocese.create(name: "Palm Beach", full_name: "Diocese of Palm Beach", state_id: 10)
Diocese.create(name: "Pensacola-Tallahassee", full_name: "Diocese of Pensacola-Tallahassee", state_id: 10)
Diocese.create(name: "St. Augustine", full_name: "Diocese of St. Augustine", state_id: 10)
Diocese.create(name: "St. Petersburg", full_name: "Diocese of St. Petersburg", state_id: 10)
Diocese.create(name: "Venice", full_name: "Diocese of Venice", state_id: 10)
Diocese.create(name: "Atlanta", full_name: "Archdiocese of Atlanta", state_id: 11)
Diocese.create(name: "Savannah", full_name: "Diocese of Savannah", state_id: 11)
Diocese.create(name: "Honolulu", full_name: "Diocese of Honolulu", state_id: 12)
Diocese.create(name: "Boise", full_name: "Diocese of Boise", state_id: 13)
Diocese.create(name: "Belleville", full_name: "Diocese of Belleville", state_id: 14)
Diocese.create(name: "Chicago", full_name: "Archdiocese of Chicago", state_id: 14)
Diocese.create(name: "Joliet", full_name: "Diocese of Joliet", state_id: 14)
Diocese.create(name: "Peoria", full_name: "Diocese of Peoria", state_id: 14)
Diocese.create(name: "Rockford", full_name: "Diocese of Rockford", state_id: 14)
Diocese.create(name: "Springfield (IL)", full_name: "Diocese of Springfield in Illinois", state_id: 14)
Diocese.create(name: "St. Nicholas", full_name: "St. Nicholas of Chicago for Ukrainians", state_id: 14)
Diocese.create(name: "St. Thomas", full_name: "St. Thomas Syro Malabar Diocese of Chicago", state_id: 14)
Diocese.create(name: "Evansville", full_name: "Diocese of Evansville", state_id: 15)
Diocese.create(name: "Fort Wayne-South Bend", full_name: "Diocese of Fort Wayne-South Bend", state_id: 15)
Diocese.create(name: "Gary", full_name: "Diocese of Gary", state_id: 15)
Diocese.create(name: "Indianapolis", full_name: "Archdiocese of Indianapolis", state_id: 15)
Diocese.create(name: "Lafayette (IN)", full_name: "Diocese of Lafayette in Indiana", state_id: 15)
Diocese.create(name: "Davenport", full_name: "Diocese of Davenport", state_id: 16)
Diocese.create(name: "Des Moines", full_name: "Diocese of Des Moines", state_id: 16)
Diocese.create(name: "Dubuque", full_name: "Archdiocese of Dubuque", state_id: 16)
Diocese.create(name: "Sioux City", full_name: "Diocese of Sioux City", state_id: 16)
Diocese.create(name: "Dodge City", full_name: "Diocese of Dodge City", state_id: 17)
Diocese.create(name: "Kansas City (KS)", full_name: "Archdiocese of Kansas City in Kansas", state_id: 17)
Diocese.create(name: "Salina", full_name: "Diocese of Salina", state_id: 17)
Diocese.create(name: "Wichita", full_name: "Diocese of Wichita", state_id: 17)
Diocese.create(name: "Covington", full_name: "Diocese of Covington", state_id: 18)
Diocese.create(name: "Lexington", full_name: "Diocese of Lexington", state_id: 18)
Diocese.create(name: "Louisville", full_name: "Archdiocese of Louisville", state_id: 18)
Diocese.create(name: "Owensboro", full_name: "Diocese of Owensboro", state_id: 18)
Diocese.create(name: "Alexandria", full_name: "Diocese of Alexandria", state_id: 19)
Diocese.create(name: "Baton Rouge", full_name: "Diocese of Baton Rouge", state_id: 19)
Diocese.create(name: "Houma-Thibodaux", full_name: "Diocese of Houma-Thibodaux", state_id: 19)
Diocese.create(name: "Lafayette (LA)", full_name: "Diocese of Lafayette in Louisiana", state_id: 19)
Diocese.create(name: "Lake Charles", full_name: "Diocese of Lake Charles", state_id: 19)
Diocese.create(name: "New Orleans", full_name: "Archdiocese of New Orleans", state_id: 19)
Diocese.create(name: "Shreveport", full_name: "Diocese of Shreveport", state_id: 19)
Diocese.create(name: "Portland (ME)", full_name: "Diocese of Portland in Maine", state_id: 20)
Diocese.create(name: "Baltimore", full_name: "Archdiocese of Baltimore", state_id: 21)
Diocese.create(name: "Boston", full_name: "Archdiocese of Boston", state_id: 22)
Diocese.create(name: "Newton", full_name: "Eparchy of Newton", state_id: 22)
Diocese.create(name: "Fall River", full_name: "Diocese of Fall River", state_id: 22)
Diocese.create(name: "Springfield (MA)", full_name: "Diocese of Springfield in Massachusetts", state_id: 22)
Diocese.create(name: "Worcester", full_name: "Diocese of Worcester", state_id: 22)
Diocese.create(name: "St. Thomas the Apostle (MI)", full_name: "Chaldean Eparchy of Saint Thomas the Apostle", state_id: 23)
Diocese.create(name: "Detroit", full_name: "Archdiocese of Detroit", state_id: 23)
Diocese.create(name: "Gaylord", full_name: "Diocese of Gaylord", state_id: 23)
Diocese.create(name: "Grand Rapids", full_name: "Diocese of Grand Rapids", state_id: 23)
Diocese.create(name: "Kalamazoo", full_name: "Diocese of Kalamazoo", state_id: 23)
Diocese.create(name: "Lansing", full_name: "Diocese of Lansing", state_id: 23)
Diocese.create(name: "Marquette", full_name: "Diocese of Marquette", state_id: 23)
Diocese.create(name: "Saginaw", full_name: "Diocese of Saginaw", state_id: 23)
Diocese.create(name: "Crookston", full_name: "Diocese of Crookston", state_id: 24)
Diocese.create(name: "Duluth", full_name: "Diocese of Duluth", state_id: 24)
Diocese.create(name: "New Ulm", full_name: "Diocese of New Ulm", state_id: 24)
Diocese.create(name: "St. Cloud", full_name: "Diocese of St. Cloud", state_id: 24)
Diocese.create(name: "St. Paul and Minneapolis", full_name: "Archdiocese of St. Paul and Minneapolis", state_id: 24)
Diocese.create(name: "Winona", full_name: "Diocese of Winona", state_id: 24)
Diocese.create(name: "Biloxi", full_name: "Diocese of Biloxi", state_id: 25)
Diocese.create(name: "Jackson", full_name: "Diocese of Jackson", state_id: 25)
Diocese.create(name: "Jefferson City", full_name: "Diocese of Jefferson City", state_id: 26)
Diocese.create(name: "Kansas City (MO)", full_name: "Diocese of Kansas City - St. Joseph", state_id: 26)
Diocese.create(name: "Our Lady of Lebanon", full_name: "Maronite Eparchy of Our Lady of Lebanon", state_id: 26)
Diocese.create(name: "Springfield (MO)", full_name: "Diocese of Springfield-Cape Girardeau", state_id: 26)
Diocese.create(name: "St. Louis", full_name: "Archdiocese of St. Louis", state_id: 26)
Diocese.create(name: "Great Falls-Billings", full_name: "Diocese of Great Falls-Billings", state_id: 27)
Diocese.create(name: "Helena", full_name: "Diocese of Helena", state_id: 27)
Diocese.create(name: "Grand Island", full_name: "Diocese of Grand Island", state_id: 28)
Diocese.create(name: "Lincoln", full_name: "Diocese of Lincoln", state_id: 28)
Diocese.create(name: "Omaha", full_name: "Archdiocese of Omaha", state_id: 28)
Diocese.create(name: "Las Vegas", full_name: "Diocese of Las Vegas", state_id: 29)
Diocese.create(name: "Reno", full_name: "Diocese of Reno", state_id: 29)
Diocese.create(name: "Manchester", full_name: "Diocese of Manchester", state_id: 30)
Diocese.create(name: "Passaic", full_name: "Byzantine Catholic Eparchy of Passaic", state_id: 31)
Diocese.create(name: "Camden", full_name: "Diocese of Camden", state_id: 31)
Diocese.create(name: "Our Lady of Deliverance", full_name: "Eparchy of Our Lady of Deliverance Syriac Catholic Diocese in the United States and Canada", state_id: 31)
Diocese.create(name: "Metuchen", full_name: "Diocese of Metuchen", state_id: 31)
Diocese.create(name: "Newark", full_name: "Archdiocese of Newark", state_id: 31)
Diocese.create(name: "Paterson", full_name: "Diocese of Paterson", state_id: 31)
Diocese.create(name: "Trenton", full_name: "Diocese of Trenton", state_id: 31)
Diocese.create(name: "Gallup", full_name: "Diocese of Gallup", state_id: 32)
Diocese.create(name: "Las Cruces", full_name: "Diocese of Las Cruces", state_id: 32)
Diocese.create(name: "Santa Fe", full_name: "Archdiocese of Santa Fe", state_id: 32)
Diocese.create(name: "Albany", full_name: "Diocese of Albany", state_id: 33)
Diocese.create(name: "Our Lady of Nareg", full_name: "Armenian Catholic Eparchy of Our Lady of Nareg in the United States and Canada", state_id: 33)
Diocese.create(name: "Brooklyn", full_name: "Diocese of Brooklyn", state_id: 33)
Diocese.create(name: "Buffalo", full_name: "Diocese of Buffalo", state_id: 33)
Diocese.create(name: "St. Maron", full_name: "Eparchy of St. Maron of Brooklyn", state_id: 33)
Diocese.create(name: "New York", full_name: "Archdiocese of New York", state_id: 33)
Diocese.create(name: "Ogdensburg", full_name: "Diocese of Ogdensburg", state_id: 33)
Diocese.create(name: "Rochester", full_name: "Diocese of Rochester", state_id: 33)
Diocese.create(name: "Rockville Centre", full_name: "Diocese of Rockville Centre", state_id: 33)
Diocese.create(name: "Syracuse", full_name: "Diocese of Syracuse", state_id: 33)
Diocese.create(name: "Syro-Malankara", full_name: "Syro-Malankara Catholic Exarchate in USA", state_id: 33)
Diocese.create(name: "Charlotte", full_name: "Diocese of Charlotte", state_id: 34)
Diocese.create(name: "Raleigh", full_name: "Diocese of Raleigh", state_id: 34)
Diocese.create(name: "Bismarck", full_name: "Diocese of Bismarck", state_id: 35)
Diocese.create(name: "Fargo", full_name: "Diocese of Fargo", state_id: 35)
Diocese.create(name: "Cincinnati", full_name: "Archdiocese of Cincinnati", state_id: 36)
Diocese.create(name: "Cleveland", full_name: "Diocese of Cleveland", state_id: 36)
Diocese.create(name: "Columbus", full_name: "Diocese of Columbus", state_id: 36)
Diocese.create(name: "Parma", full_name: "Eparchy of Parma", state_id: 36)
Diocese.create(name: "St. George", full_name: "Eparchy of St. George in Canton for the Romanians", state_id: 36)
Diocese.create(name: "Steubenville", full_name: "Diocese of Steubenville", state_id: 36)
Diocese.create(name: "Toledo", full_name: "Diocese of Toledo", state_id: 36)
Diocese.create(name: "St. Josaphat", full_name: "Ukrainian Catholic Eparchy of St. Josaphat - Parma, OH", state_id: 36)
Diocese.create(name: "Youngstown", full_name: "Diocese of Youngstown", state_id: 36)
Diocese.create(name: "Oklahoma City", full_name: "Archdiocese of Oklahoma City", state_id: 37)
Diocese.create(name: "Tulsa", full_name: "Diocese of Tulsa", state_id: 37)
Diocese.create(name: "Baker", full_name: "Diocese of Baker", state_id: 38)
Diocese.create(name: "Portland (OR)", full_name: "Archdiocese of Portland in Oregon", state_id: 38)
Diocese.create(name: "Allentown", full_name: "Diocese of Allentown", state_id: 39)
Diocese.create(name: "Altoona-Johnstown", full_name: "Diocese of Altoona-Johnstown", state_id: 39)
Diocese.create(name: "Pittsburgh", full_name: "Byzantine Catholic Archeparchy of Pittsburgh", state_id: 39)
Diocese.create(name: "Erie", full_name: "Diocese of Erie", state_id: 39)
Diocese.create(name: "Greensburg", full_name: "Diocese of Greensburg", state_id: 39)
Diocese.create(name: "Harrisburg", full_name: "Diocese of Harrisburg", state_id: 39)
Diocese.create(name: "Philadelphia", full_name: "Archdiocese of Philadelphia", state_id: 39)
Diocese.create(name: "Pittsburgh", full_name: "Diocese of Pittsburgh", state_id: 39)
Diocese.create(name: "Scranton", full_name: "Diocese of Scranton", state_id: 39)
Diocese.create(name: "Philadelphia", full_name: "Ukrainian Catholic Archeparchy of Philadelphia", state_id: 39)
Diocese.create(name: "Providence", full_name: "Diocese of Providence", state_id: 41)
Diocese.create(name: "Charleston", full_name: "Diocese of Charleston", state_id: 42)
Diocese.create(name: "Rapid City", full_name: "Diocese of Rapid City", state_id: 43)
Diocese.create(name: "Sioux Falls", full_name: "Diocese of Sioux Falls", state_id: 43)
Diocese.create(name: "Knoxville", full_name: "Diocese of Knoxville", state_id: 44)
Diocese.create(name: "Memphis", full_name: "Diocese of Memphis", state_id: 44)
Diocese.create(name: "Nashville", full_name: "Diocese of Nashville", state_id: 44)
Diocese.create(name: "Amarillo", full_name: "Diocese of Amarillo", state_id: 45)
Diocese.create(name: "Austin", full_name: "Diocese of Austin", state_id: 45)
Diocese.create(name: "Beaumont", full_name: "Diocese of Beaumont", state_id: 45)
Diocese.create(name: "Brownsville", full_name: "Diocese of Brownsville", state_id: 45)
Diocese.create(name: "Corpus Christi", full_name: "Diocese of Corpus Christi", state_id: 45)
Diocese.create(name: "Dallas", full_name: "Diocese of Dallas", state_id: 45)
Diocese.create(name: "El Paso", full_name: "Diocese of El Paso", state_id: 45)
Diocese.create(name: "Fort Worth", full_name: "Diocese of Fort Worth", state_id: 45)
Diocese.create(name: "Galveston-Houston", full_name: "Archdiocese of Galveston-Houston", state_id: 45)
Diocese.create(name: "Laredo", full_name: "Diocese of Laredo", state_id: 45)
Diocese.create(name: "Lubbock", full_name: "Diocese of Lubbock", state_id: 45)
Diocese.create(name: "San Angelo", full_name: "Diocese of San Angelo", state_id: 45)
Diocese.create(name: "San Antonio", full_name: "Archdiocese of San Antonio", state_id: 45)
Diocese.create(name: "St. Peter", full_name: "Diocese of The Personal Ordinariate of the Chair of St. Peter", state_id: 45)
Diocese.create(name: "Tyler", full_name: "Diocese of Tyler", state_id: 45)
Diocese.create(name: "Victoria", full_name: "Diocese of Victoria", state_id: 45)
Diocese.create(name: "Salt Lake City", full_name: "Diocese of Salt Lake City", state_id: 46)
Diocese.create(name: "Burlington", full_name: "Diocese of Burlington", state_id: 47)
Diocese.create(name: "St. Thomas (VI)", full_name: "Diocese of St. Thomas, VI")
Diocese.create(name: "Arlington", full_name: "Diocese of Arlington", state_id: 48)
Diocese.create(name: "Richmond", full_name: "Diocese of Richmond", state_id: 48)
Diocese.create(name: "Seattle", full_name: "Archdiocese of Seattle", state_id: 49)
Diocese.create(name: "Spokane", full_name: "Diocese of Spokane", state_id: 49)
Diocese.create(name: "Yakima", full_name: "Diocese of Yakima", state_id: 49)
Diocese.create(name: "Wheeling-Charleston", full_name: "Diocese of Wheeling-Charleston", state_id: 50)
Diocese.create(name: "Green Bay", full_name: "Diocese of Green Bay", state_id: 51)
Diocese.create(name: "La Crosse", full_name: "Diocese of La Crosse", state_id: 51)
Diocese.create(name: "Madison", full_name: "Diocese of Madison", state_id: 51)
Diocese.create(name: "Milwaukee", full_name: "Archdiocese of Milwaukee", state_id: 51)
Diocese.create(name: "Superior", full_name: "Diocese of Superior", state_id: 51)
Diocese.create(name: "Cheyenne", full_name: "Diocese of Cheyenne", state_id: 52)
# End Dioceses

# Begin AccountStatuses
AccountStatus.create(name: "inactive")
AccountStatus.create(name: "active")
# End AccountStatuses

# Begin AccountRoles
AccountRole.create(name: "superuser")
AccountRole.create(name: "administrator")
AccountRole.create(name: "confessor")
AccountRole.create(name: "penitent")
AccountRole.create(name: "test")
# End AccountRoles

# Begin ConfessorRequestStatuses
ConfessorRequestStatus.create(name: "created")
ConfessorRequestStatus.create(name: "pending")
ConfessorRequestStatus.create(name: "approved")
ConfessorRequestStatus.create(name: "denied")
# End ConfessorRequestStatuses

# Begin ConfessorOffices
ConfessorOffice.create(name: "pope")
ConfessorOffice.create(name: "cardinal")
ConfessorOffice.create(name: "archbishop")
ConfessorOffice.create(name: "bishop")
ConfessorOffice.create(name: "priest")
# End ConfessorOffices

# Begin ConfessorStatuses
ConfessorStatus.create(name: "in")
ConfessorStatus.create(name: "out")
ConfessorStatus.create(name: "busy")
# End ConfessorStatuses

#=========== End Static Data. ================================#

=begin
# Begin Confession Locations
ConfessionLocation.create(name: "Saint Mary of Pine Bluff",
                          nickname: "Saint Mary's",
                          street_address: "3673 County Highway P",
                          city: "Cross Plains",
                          state: 51,
                          postal_code: "53528")
ConfessionLocationChange.create(name: "Saint Mary of Pine Bluff",
                          nickname: "Saint Mary's",
                          street_address: "3673 County Highway P",
                          city: "Cross Plains",
                          state: 51,
                          postal_code: "53528",
                          change_comments: "created",
                          user_account_id: 1,
                          confession_location_id: 1)

ConfessionLocation.create(name: "Saint Ignatius Catholic Church",
                          nickname: "Saint Ignatius",
                          street_address: "109 South 6th Street",
                          city: "Mount Horeb",
                          state: 51,
                          postal_code: "53572")
ConfessionLocation.create(name: "Saint Ignatius Catholic Church",
                          nickname: "Saint Ignatius",
                          street_address: "109 South 6th Street",
                          city: "Mount Horeb",
                          state: 51,
                          postal_code: "53572",
                          change_comments: "created",
                          user_account_id: 1,
                          confession_location_id: 2)

ConfessionLocation.create(name: "Saint Christopher Catholic Parish",
                          nickname: "Saint Christopher",
                          street_address: "301 N Main St",
                          city: "Verona",
                          state: 51,
                          postal_code: "53593")
ConfessionLocation.create(name: "Saint Christopher Catholic Parish",
                          nickname: "Saint Christopher",
                          street_address: "301 N Main St",
                          city: "Verona",
                          state: 51,
                          postal_code: "53593",
                          change_comments: "created",
                          user_account_id: 1,
                          confession_location_id: 3)

ConfessionLocation.create(name: "Saint Peter Cathedral",
                          nickname: "Saint Peter's",
                          street_address: "311 West Baraga Ave",
                          city: "Marquette",
                          state: 23,
                          postal_code: "49855")
ConfessionLocation.create(name: "Saint Peter Cathedral",
                          nickname: "Saint Peter's",
                          street_address: "311 West Baraga Ave",
                          city: "Marquette",
                          state: 23,
                          postal_code: "49855",
                          change_comments: "created",
                          user_account_id: 1,
                          confession_location_id: 4)
# End Confession Locations
=end

# Begin UserAccounts
UserAccount.create(first_name: "Roland",
                   last_name: "Scott",
                   username: "roland.scott@gmail.com",
                   password: "asdf",
                   account_status_id: 2,
                   email: "roland.scott@gmail.com",
                   home_phone: "6084370956",
                   work_phone: "6087771087",
                   mobile_phone: "6083978765")
UserAccountChange.create(first_name: "Roland",
                   last_name: "Scott",
                   username: "roland.scott@gmail.com",
                   password: "asdf",
                   account_status_id: 2,
                   email: "roland.scott@gmail.com",
                   home_phone: "6084370956",
                   work_phone: "6087771087",
                   mobile_phone: "6083978765",
                   change_comments: "created")
                   
UserAccount.create(first_name: "Richard",
                   last_name: "Heilman",
                   username: "father_rick@gmail.com",
                   password: "asdf",
                   account_status_id: 2,
                   email: "father_rick@gmail.com",
                   home_phone: "",
                   work_phone: "6087982111",
                   mobile_phone: "")
UserAccountChange.create(first_name: "Richard",
                   last_name: "Heilman",
                   username: "father_rick@gmail.com",
                   password: "asdf",
                   account_status_id: 2,
                   email: "father_rick@gmail.com",
                   home_phone: "",
                   work_phone: "6087982111",
                   mobile_phone: "",
                   change_comments: "created")
                                                         
# End User Accounts


=begin
User.create(first_name: "Richard", 
            last_name: "Heilman", 
            home_phone: "6084370956", 
            mobile_phone: "6083456857",
            email: "fr_rick@gmail.com",
            street_address: "1234 Country Lane",
            city: "Pine Bluff",
            state: "48",
            diocese: "Madison",
            parish: "Saint Mary of Pine Bluff",
            password: "",
            office: 1,
            salutation: "Father Rick",
            about_me: "I love confession!",
            account_status: 2)

User.create(first_name: "Eric", 
            last_name: "Sternberg", 
            home_phone: "7467637278", 
            mobile_phone: "7468739876",
            email: "fr_stern@yahoo.com",
            street_address: "123 Front St",
            city: "Madison",
            state: "48",
            diocese: "Madison",
            parish: "Saint Thomas",
            password: "",
            office: 1,
            salutation: "Father Sternberg",
            about_me: "I live in Madison.",
            account_status: 2)

User.create(first_name: "Mark", 
            last_name: "Labry", 
            home_phone: "9064370956", 
            mobile_phone: "9063456857",
            email: "mlb@gmail.com",
            street_address: "223 Standard St.",
            city: "Marquette",
            state: "51",
            diocese: "Marquette",
            parish: "Saint Christopher",
            password: "",
            office: 1,
            salutation: "Father Labry",
            about_me: "The UP is awesome.",
            account_status: 2)

User.create(first_name: "Dominic", 
            last_name: "Savio", 
            home_phone: "6544370956", 
            mobile_phone: "6543456857",
            email: "st_dominic@gmail.com",
            street_address: "6774 Pearly Gate",
            city: "Zion",
            state: 1,
            diocese: "Westphalia",
            parish: "Saint Peter",
            password: "",
            office: 4,
            salutation: "Saint Dominic",
            about_me: "I'm in heaven",
            account_status: 2)

User.create(first_name: "Roland", 
            last_name: "Scott", 
            home_phone: "6084370956", 
            mobile_phone: "6083456857",
            email: "roland.scott@gmail.com",
            street_address: "303 North 3rd Street",
            city: "Mount Horeb",
            state: 48,
            diocese: "Madison",
            parish: "Saint Mary of Pine Bluff",
            password: "",
            salutation: "",
            about_me: "",
            account_status: 1)
            
=end
