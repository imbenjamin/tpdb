# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

attraction_types = AttractionType.create([  {name: 'Roller Coaster', description: 'A roller coaster is a type of amusement ride that employs a form of elevated railroad track designed with tight turns, steep slopes, and sometimes inversions. People ride along the track in open cars, and the rides are often found in amusement parks and theme parks around the world.'},
                                            {name: 'Dark Ride', description: 'A dark ride or ghost train is an indoor amusement ride on which passengers aboard guided vehicles travel through specially lit scenes that typically contain animation, sound, music and special effects. Appearing as early as the 19th century, exhibits such as tunnels of love, scary themes and interactive stories have been the subject of rides under the original definition.'},
                                            {name: 'Flat Ride', description: 'Flat rides are usually considered to be those that move their passengers in a plane generally parallel to the ground, such as rides that spin around a vertical axis, like carousels and twists, and ground level rides such as bumper cars and The Whip.'},
                                            {name: 'Transport Ride', description: 'Sometimes not considered a true \'ride\', transportation around theme parks could be a railroad, monorail, or any other form of transport from one place to another.'},
                                            {name: 'Simulator Ride', description: 'Simulator rides are a type of amusement park or fairground ride, where the audience is shown a movie while their seats move to correspond to the action on screen.'},
                                            {name: 'Water Ride', description: 'Water rides are amusement rides that are set over water. For instance, a log flume travels through a channel of water to move along its course.'}
                                        ])


dlr = Location.create({name: 'Disneyland Resort', description: 'The Disneyland Resort, commonly known as Disneyland, is an entertainment resort in Anaheim, California.', address: "1313 Disneyland Dr, Anaheim, CA 92802, USA"})
wdw = Location.create({name: 'Walt Disney World', description: 'The Walt Disney World Resort, also called Walt Disney World and Disney World, is an entertainment complex in Bay Lake and Lake Buena Vista, Florida, in the United States, near the cities Orlando and Kissimmee.', address: 'Walt Disney World Resort, Orlando, FL 32830, USA'})
locations = Location.create([   {name: 'Thorpe Park', description: 'Thorpe Park Resort, commonly known as Thorpe Park, is a theme park located between the towns of Chertsey and Staines-upon-Thames in Surrey.', address: "THORPE PARK Resort, Staines Rd, Chertsey KT16 8PN"},
                                {name: 'Disneyland Park', description: 'Disneyland Park, originally Disneyland, is the first of two theme parks built at the Disneyland Resort in Anaheim, California, opened on July 17, 1955. It is the only theme park designed and built to completion under the direct supervision of Walt Disney.', address: "1313 Disneyland Dr, Anaheim, CA 92802, USA", parent: dlr},
                                {name: 'Chessington World of Adventures', description: 'Chessington World of Adventures Resort is a Theme Park, Zoo and Hotel Complex in Chessington, Greater London, England, around 12 miles (19 km) southwest of Central London.', address: "Chessington World of Adventures, Leatherhead Rd, Chessington KT9 2NE"},
                                {name: 'Disney California Adventure', description: 'Disney California Adventure Park, commonly referred to as Disney California Adventure, California Adventure, or DCA, is a theme park located in Anaheim, California.', address: "1313 Disneyland Dr, Anaheim, CA 92802, USA", parent: dlr},
                                {name: 'Magic Kingdom', description: 'Magic Kingdom is a theme park at the Walt Disney World Resort in Bay Lake, Florida, near Orlando.', address: '1180 Seven Seas Dr, Lake Buena Vista, FL 32830, USA', parent: wdw},
                                {name: 'Epcot', description: 'Epcot is a theme park at the Walt Disney World Resort in Bay Lake, Florida.', address: '200 Epcot Center Dr, Orlando, FL 32821, USA', parent: wdw},
                                {name: 'Disney\'s Hollywood Studios', description: 'Disney\'s Hollywood Studios is a theme park at the Walt Disney World Resort in Bay Lake, Florida, near Orlando.', address: '351 S Studio Dr, Lake Buena Vista, FL 32830, USA', parent: wdw},
                                {name: 'Disney\'s Animal Kingdom', description: 'Disney\'s Animal Kingdom is a zoological theme park at the Walt Disney World Resort in Bay Lake, Florida, near Orlando.', address: '2901 Osceola Pkwy, Orlando, FL 32830, USA', parent: wdw},
                            ])

dlr.logo.attach(io: File.open('./seed_files/dlr.jpg'), filename: 'dlr.jpg')
locations[0].logo.attach(io: File.open('./seed_files/Thorpe-park-logo.png'), filename: 'tp.png')
locations[1].logo.attach(io: File.open('./seed_files/disneylandpark.png'), filename: 'disneylandpark.png')
locations[2].logo.attach(io: File.open('./seed_files/cwoa.png'), filename: 'cwoa.png')
locations[3].logo.attach(io: File.open('./seed_files/dca.png'), filename: 'dca.png')

areas = Area.create([   {name: 'Lost City', location: locations[0]},
                        {name: 'Port & Basecamp', location: locations[0]},
                        {name: 'Old Town', location: locations[0]},
                        {name: 'The Dock Yard', location: locations[0]},
                        {name: 'Main Street U.S.A.', description: 'Take a trip back to the good old days in small-town America', location: locations[1]},
                        {name: 'Tomorrowland', description: 'Propel yourself into the future and discover this unique land', location: locations[1]}
                    ])

areas[5].logo.attach(io: File.open('./seed_files/Tomorrowland.png'), filename: 'tomorrowland.png')

manufacturers = Manufacturer.create([   {name: 'Intamin Amusement Rides', description: 'Intamin is a designing and manufacturing company in Wollerau, Switzerland.', website: 'https://www.intaminworldwide.com/'},
                                        {name: 'Gerstlauer Amusement Rides', description: 'Gerstlauer is a German manufacturer of stationary and transportable amusement rides and roller coasters, located in Münsterhausen, Germany.', website: 'https://www.gerstlauer-rides.de/'},
                                        {name: 'Mondial', description: 'Mondial is a Dutch company specialising in the manufacture of amusement rides.', website: 'http://www.mondialrides.com/'},
                                        {name: 'Dynamic Attractions', description: 'Dynamic Structures is a Canadian company with a history of steel fabrication dating back to 1926. They create amusement rides, theme park rides, observatory telescopes and other complex steel structures.', website: 'http://dynamicattractions.com/'},
                                        {name: 'WED Enterprises', description: 'Retlaw Enterprises, originally Walt Disney Miniature Railroad, then Walt Disney, Inc. (WDI), and then WED Enterprises (WED), was a privately held company owned by the heirs of entertainment mogul Walt Disney.', website: ''},
                                        {name: 'Arrow Dynamics', description: 'Arrow Dynamics was a roller coaster design and manufacturing company based in Clearfield, Utah, United States.', website: ''},
                                        {name: 'Mack Rides', description: 'Mack Rides is a German company that designs and constructs amusement rides, based in Waldkirch, Baden-Württemberg, Germany. It is one of the world\'s oldest amusement industry suppliers', website: 'http://www.mack-rides.com/'}
                                    ])

attractions = Attraction.create([   {name: 'Colossus', description: 'The Power of 10 - The World\'s First 10 Looping Coaster', length: 850, height: 30, inversions: 10, top_speed: 20, capacity: 1300, attraction_type: attraction_types[0], location: locations[0], area: areas[0], manufacturer: manufacturers[0]},
                                    {name: 'SAW: The Ride', description: 'Escape Jigsaw if you can. Let the game begin...', length: 720, height: 30, inversions: 3, top_speed: 24.72, capacity: 1100, attraction_type: attraction_types[0], location: locations[0], area: areas[2], manufacturer: manufacturers[1]},
                                    {name: 'Derren Brown\'s Ghost Train', description: 'A Ghost Train like no other, featuring VR technology', capacity: 750, attraction_type: attraction_types[1], location: locations[0], area: areas[3], manufacturer: manufacturers[0]},
                                    {name: 'Samurai', height: 18, capacity: 500, attraction_type: attraction_types[2], location: locations[0], area: areas[2], manufacturer: manufacturers[2]},
                                    {name: 'Space Mountain', description: 'The iconic indoor coaster, only at Disney Parks', height: 23, inversions: 0, attraction_type: attraction_types[0], location: locations[1], area: areas[5], manufacturer: manufacturers[3]},
                                    {name: 'Disneyland Railroad', description: 'All Aboard!', attraction_type: attraction_types[3], location: locations[1], manufacturer: manufacturers[4]},
                                    {name: 'Vampire', description: 'Board this classic family hanging coaster', height: 21, length: 670, top_speed: 24.72, inversions: 0, capacity: 1080, attraction_type: attraction_types[0], location: locations[2], manufacturer: manufacturers[5]},
                                    {name: 'The Gruffalo River Ride Adventure', capacity: 1000, attraction_type: attraction_types[1], location: locations[2], manufacturer: manufacturers[6]}
                                ])