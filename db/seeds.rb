# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create({email: 'admin@tpdb.com', password: 'test1234', password_confirmation: 'test1234', admin: true})
contributor = User.create({email: 'contributor@gmail.com', password: 'test1234', password_confirmation: 'test1234'})

type_rollercoaster = AttractionType.create({name: 'Roller Coaster', description: 'A roller coaster is a type of amusement ride that employs a form of elevated railroad track designed with tight turns, steep slopes, and sometimes inversions. People ride along the track in open cars, and the rides are often found in amusement parks and theme parks around the world.'})
type_darkride = AttractionType.create({name: 'Dark Ride', description: 'A dark ride or ghost train is an indoor amusement ride on which passengers aboard guided vehicles travel through specially lit scenes that typically contain animation, sound, music and special effects. Appearing as early as the 19th century, exhibits such as tunnels of love, scary themes and interactive stories have been the subject of rides under the original definition.'})
type_flatride = AttractionType.create({name: 'Flat Ride', description: 'Flat rides are usually considered to be those that move their passengers in a plane generally parallel to the ground, such as rides that spin around a vertical axis, like carousels and twists, and ground level rides such as bumper cars and The Whip.'})
type_transportride = AttractionType.create({name: 'Transport Ride', description: 'Sometimes not considered a true \'ride\', transportation around theme parks could be a railroad, monorail, or any other form of transport from one place to another.'})
type_simulatorride = AttractionType.create({name: 'Simulator Ride', description: 'Simulator rides are a type of amusement park or fairground ride, where the audience is shown a movie while their seats move to correspond to the action on screen.'})
type_waterride = AttractionType.create({name: 'Water Ride', description: 'Water rides are amusement rides that are set over water. For instance, a log flume travels through a channel of water to move along its course.'})
type_stageshow = AttractionType.create({name: 'Stage Show', description: 'A live or anomatronic show designed to entertain guests in a theatre-type setting.'})
type_titr = AttractionType.create({name: 'Theatre In The Round', description: 'An arena-type show where guests are surrounded and/or surrounding the action.'})
type_walkthrough = AttractionType.create({name: 'Walk-through', description: 'An attraction where guests walk through scenes.'})

dlr = Location.create({name: 'Disneyland Resort', description: 'The Disneyland Resort, commonly known as Disneyland, is an entertainment resort in Anaheim, California.', address: "1313 Disneyland Dr, Anaheim, CA 92802, USA"})
wdw = Location.create({name: 'Walt Disney World', description: 'The Walt Disney World Resort, also called Walt Disney World and Disney World, is an entertainment complex in Bay Lake and Lake Buena Vista, Florida, in the United States, near the cities Orlando and Kissimmee.', address: 'Walt Disney World Resort, Orlando, FL 32830, USA'})
dlr_dlp = Location.create({name: 'Disneyland Park', description: 'Disneyland Park, originally Disneyland, is the first of two theme parks built at the Disneyland Resort in Anaheim, California, opened on July 17, 1955. It is the only theme park designed and built to completion under the direct supervision of Walt Disney.', address: "1313 Disneyland Dr, Anaheim, CA 92802, USA", parent: dlr})
dlr_dca = Location.create({name: 'Disney California Adventure', description: 'Disney California Adventure Park, commonly referred to as Disney California Adventure, California Adventure, or DCA, is a theme park located in Anaheim, California.', address: "1313 Disneyland Dr, Anaheim, CA 92802, USA", parent: dlr})
wdw_mk = Location.create({name: 'Magic Kingdom', description: 'Magic Kingdom is a theme park at the Walt Disney World Resort in Bay Lake, Florida, near Orlando.', address: '1180 Seven Seas Dr, Lake Buena Vista, FL 32830, USA', parent: wdw})
wdw_epcot = Location.create({name: 'Epcot', description: 'Epcot is a theme park at the Walt Disney World Resort in Bay Lake, Florida.', address: '200 Epcot Center Dr, Orlando, FL 32821, USA', parent: wdw})
wdw_dhs = Location.create({name: 'Disney\'s Hollywood Studios', description: 'Disney\'s Hollywood Studios is a theme park at the Walt Disney World Resort in Bay Lake, Florida, near Orlando.', address: '351 S Studio Dr, Lake Buena Vista, FL 32830, USA', parent: wdw})
wdw_dak = Location.create({name: 'Disney\'s Animal Kingdom', description: 'Disney\'s Animal Kingdom is a zoological theme park at the Walt Disney World Resort in Bay Lake, Florida, near Orlando.', address: '2901 Osceola Pkwy, Orlando, FL 32830, USA', parent: wdw})

locations = Location.create([   {name: 'Thorpe Park', description: 'Thorpe Park Resort, commonly known as Thorpe Park, is a theme park located between the towns of Chertsey and Staines-upon-Thames in Surrey.', address: "THORPE PARK Resort, Staines Rd, Chertsey KT16 8PN"},
                                {name: 'Chessington World of Adventures', description: 'Chessington World of Adventures Resort is a Theme Park, Zoo and Hotel Complex in Chessington, Greater London, England, around 12 miles (19 km) southwest of Central London.', address: "Chessington World of Adventures, Leatherhead Rd, Chessington KT9 2NE"}
                            ])

dlr.logo.attach(io: File.open('./seed_files/dlr.jpg'), filename: 'dlr.jpg')
dlr_dlp.logo.attach(io: File.open('./seed_files/disneylandpark.png'), filename: 'disneylandpark.png')
dlr_dca.logo.attach(io: File.open('./seed_files/dca.png'), filename: 'dca.png')
locations[0].logo.attach(io: File.open('./seed_files/Thorpe-park-logo.png'), filename: 'tp.png')
locations[1].logo.attach(io: File.open('./seed_files/cwoa.png'), filename: 'cwoa.png')

thorpe_park_areas = Area.create([   {name: 'Lost City', location: locations[0]},
                                    {name: 'Port & Basecamp', location: locations[0]},
                                    {name: 'Old Town', location: locations[0]},
                                    {name: 'The Dock Yard', location: locations[0]}
                    ])
dlr_areas = Area.create([   {name: 'Main Street U.S.A.', description: 'Take a trip back to the good old days in small-town America', location: dlr_dlp},
                            {name: 'Frontierland', description: 'Themed to the American Old West of the 19th century, Frontierlands are home to cowboys and pioneers, saloons, red rock buttes and gold rushes.', location: dlr_dlp},
                            {name: 'Adventureland', description: 'Adventureland provides a 1950s view of exotic adventure, capitalizing on the post-war Tiki craze.', location: dlr_dlp},
                            {name: 'New Orleans Square', description: 'Based on 19th-century New Orleans, Louisiana, the roughly three-acre area was the first land to be added to Disneyland after the park\'s opening, at a cost of $18 million.', location: dlr_dlp},
                            {name: 'Critter Country', description: 'The area now known as Critter Country was originally named Indian Village.', location: dlr_dlp},
                            {name: 'Fantasyland', description: 'Fantasyland is one of the original themed lands at Disneyland. Fantasyland features Sleeping Beauty Castle at its front, which is also the park\'s icon, and a central courtyard dominated by King Arthur\'s Carrousel.', location: dlr_dlp},
                            {name: 'Mickey\'s Toontown', description: 'The attraction is a small-scale recreation of the Mickey Mouse universe where visitors can meet the characters and visit their homes which are constructed in a cartoonish style.', location: dlr_dlp},
                            {name: 'Tomorrowland', description: 'Propel yourself into the future and discover this unique land', location: dlr_dlp}

])
dlr_areas[7].logo.attach(io: File.open('./seed_files/Tomorrowland.png'), filename: 'tomorrowland.png')

manufacturers = Manufacturer.create([   {name: 'Intamin Amusement Rides', description: 'Intamin is a designing and manufacturing company in Wollerau, Switzerland.', website: 'https://www.intaminworldwide.com/'},
                                        {name: 'Gerstlauer Amusement Rides', description: 'Gerstlauer is a German manufacturer of stationary and transportable amusement rides and roller coasters, located in Münsterhausen, Germany.', website: 'https://www.gerstlauer-rides.de/'},
                                        {name: 'Mondial', description: 'Mondial is a Dutch company specialising in the manufacture of amusement rides.', website: 'http://www.mondialrides.com/'},
                                        {name: 'Dynamic Attractions', description: 'Dynamic Structures is a Canadian company with a history of steel fabrication dating back to 1926. They create amusement rides, theme park rides, observatory telescopes and other complex steel structures.', website: 'http://dynamicattractions.com/'},
                                        {name: 'WED Enterprises', description: 'Retlaw Enterprises, originally Walt Disney Miniature Railroad, then Walt Disney, Inc. (WDI), and then WED Enterprises (WED), was a privately held company owned by the heirs of entertainment mogul Walt Disney.', website: ''},
                                        {name: 'Arrow Dynamics', description: 'Arrow Dynamics was a roller coaster design and manufacturing company based in Clearfield, Utah, United States.', website: ''},
                                        {name: 'Mack Rides', description: 'Mack Rides is a German company that designs and constructs amusement rides, based in Waldkirch, Baden-Württemberg, Germany. It is one of the world\'s oldest amusement industry suppliers', website: 'http://www.mack-rides.com/'},
                                        {name: 'Walt Disney Imagineering', description: 'After WED Enterprises came Walt Disney Imagineering. Legendary among interactive storytelling.'},
                                        {name: 'Hopkins Rides', description: 'Hopkins Rides is an amusement ride manufacturer based in Palm City, Florida.[1] The company has had experience in amusement rides for over 45 years and currently specializes in water rides.', website: 'https://www.whitewaterwest.com/'}
                                    ])

dlp_attractions = Attraction.create([   {
                                            name: 'Great Moments with Mr. Lincoln', 
                                            description: 'Great Moments with Mr. Lincoln is a stage show featuring an Audio-Animatronic representation of U.S. President Abraham Lincoln, best known for being presented at Disneyland since 1965.', 
                                            attraction_type: type_stageshow,
                                            location: dlr_dlp,
                                            area: dlr_areas[0],
                                            manufacturer: manufacturers[4],
                                            opening_date: '1965/07/18'
                                        },
                                        {
                                            name: 'Big Thunder Mountain Railroad',
                                            description: 'A mine train roller coaster located in Frontierland at several Disneyland-style Disney Parks worldwide.',
                                            attraction_type: type_rollercoaster,
                                            location: dlr_dlp,
                                            area: dlr_areas[1],
                                            manufacturer: manufacturers[3],
                                            length: 814.1208,
                                            top_speed: 12.5171,
                                            inversions: 0,
                                            capacity: 2400,
                                            opening_date: '1979/09/02'
                                        },
                                        {
                                            name: 'Mark Twain Riverboat',
                                            description: 'Passengers embark on a scenic, 12-minute journey around the Rivers of America.',
                                            attraction_type: type_transportride,
                                            location: dlr_dlp,
                                            area: dlr_areas[1],
                                            manufacturer: manufacturers[4],
                                            opening_date: '1955/07/17'
                                        },
                                        {
                                            name: 'Indiana Jones Adventure',
                                            description: 'Guests accompany intrepid archaeologist Dr. Indiana Jones on a turbulent quest, aboard military troop transport vehicles, through a dangerous lost temple guarded by a supernatural power.',
                                            attraction_type: type_darkride,
                                            location: dlr_dlp,
                                            area: dlr_areas[2],
                                            manufacturer: manufacturers[7],
                                            length: 760,
                                            opening_date: '1995/03/04'
                                        },
                                        {
                                            name: 'Jungle Cruise',
                                            description: 'The attraction simulates a riverboat cruise down several major rivers of Asia, Africa and South America. Park guests board replica tramp steamers from a 1930s British explorers\' lodge and are taken on a voyage past many different Audio-Animatronic jungle animals.',
                                            attraction_type: type_waterride,
                                            location: dlr_dlp,
                                            area: dlr_areas[2],
                                            manufacturer: manufacturers[7],
                                            opening_date: '1955/07/17'
                                        },
                                        {
                                            name: 'Walt Disney\'s Enchanted Tiki Room',
                                            description: 'Opened in 1963 at the Disneyland Resort, the attraction is a pseudo-Polynesian themed musical animatronic show drawing from American tiki culture.',
                                            attraction_type: type_titr,
                                            location: dlr_dlp,
                                            area: dlr_areas[2],
                                            manufacturer: manufacturers[4],
                                            opening_date: '1963/06/23'
                                        },
                                        {
                                            name: 'Tarzan\'s Treehouse',
                                            description: 'In February 1999, Disneyland closed its version of the Swiss Family Treehouse, and Imagineers re-themed the attraction to coincide with the soon to be released Tarzan film.',
                                            attraction_type: type_walkthrough,
                                            location: dlr_dlp,
                                            area: dlr_areas[2],
                                            manufacturer: manufacturers[7],
                                            opening_date: '1999/06/23'
                                        },
                                        {
                                            name: 'The Haunted Mansion',
                                            description: 'The attraction, although differing slightly in every location, places riders inside a haunted manor resided in by "999 happy haunts".',
                                            attraction_type: type_darkride,
                                            location: dlr_dlp,
                                            area: dlr_areas[3],
                                            manufacturer: manufacturers[4],
                                            opening_date: '1969/08/09'
                                        },
                                        {
                                            name: 'Pirates of the Caribbean',
                                            description: 'The original version at Disneyland, which opened in 1967, was the last attraction whose construction was overseen by Walt Disney.',
                                            attraction_type: type_waterride,
                                            location: dlr_dlp,
                                            area: dlr_areas[3],
                                            manufacturer: manufacturers[5],
                                            opening_date: '1967/03/18'
                                        },
                                        {
                                            name: 'The Many Adventures of Winnie-the-Pooh',
                                            description: 'A dark ride based upon the film of the same name, itself based on the Winnie-the-Pooh books by A. A. Milne.',
                                            attraction_type: type_darkride,
                                            location: dlr_dlp,
                                            area: dlr_areas[4],
                                            manufacturer: manufacturers[7],
                                            opening_date: '2003/04/11'
                                        },
                                        {
                                            name: 'Splash Mountain',
                                            description: 'The plot behind Splash Mountain is a composite of several Uncle Remus stories.',
                                            attraction_type: type_waterride,
                                            location: dlr_dlp,
                                            area: dlr_areas[4],
                                            manufacturer: manufacturers[8],
                                            opening_date: '1989/07/17',
                                            top_speed: 17.8816,
                                            length: 804.672,
                                            height: 15
                                        },
                                        {name: 'Space Mountain', description: 'The iconic indoor coaster, only at Disney Parks', height: 23, inversions: 0, attraction_type: type_rollercoaster, location: dlr_dlp, area: dlr_areas[7], manufacturer: manufacturers[3]},
                                        {name: 'Disneyland Railroad', description: 'All Aboard!', attraction_type: type_transportride, location: dlr_dlp, manufacturer: manufacturers[4]}
])

# attractions = Attraction.create([   {name: 'Colossus', description: 'The Power of 10 - The World\'s First 10 Looping Coaster', length: 850, height: 30, inversions: 10, top_speed: 20, capacity: 1300, attraction_type: type_rollercoaster, location: locations[0], area: thorpe_park_areas[0], manufacturer: manufacturers[0]},
#                                     {name: 'SAW: The Ride', description: 'Escape Jigsaw if you can. Let the game begin...', length: 720, height: 30, inversions: 3, top_speed: 24.72, capacity: 1100, attraction_type: type_rollercoaster, location: locations[0], area: thorpe_park_areas[2], manufacturer: manufacturers[1]},
#                                     {name: 'Derren Brown\'s Ghost Train', description: 'A Ghost Train like no other, featuring VR technology', capacity: 750, attraction_type: type_darkride, location: locations[0], area: thorpe_park_areas[3], manufacturer: manufacturers[0]},
#                                     {name: 'Samurai', height: 18, capacity: 500, attraction_type: type_flatride, location: locations[0], area: thorpe_park_areas[2], manufacturer: manufacturers[2]},
#                                     {name: 'Vampire', description: 'Board this classic family hanging coaster', height: 21, length: 670, top_speed: 24.72, inversions: 0, capacity: 1080, attraction_type: type_rollercoaster, location: locations[1], manufacturer: manufacturers[5]},
#                                     {name: 'The Gruffalo River Ride Adventure', capacity: 1000, attraction_type: type_waterride, location: locations[1], manufacturer: manufacturers[6]}
#                                 ])