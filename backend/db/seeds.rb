PostTag.destroy_all
PostLike.destroy_all
Comment.destroy_all
Post.destroy_all
CommunityOwner.destroy_all
UserCommunity.destroy_all
Community.destroy_all
User.destroy_all

@jack = User.create username: "Jack", age: 27, email: "jack@gjeffgolden.com", password: "password"
@ryan = User.create username: "Ryan", age: 73, email: "ryan@gjeffgolden.com", password: "password"
@stephen = User.create username: "Stephen", age: 197, email: "stephen@gjeffgolden.com", password: "password"
@raz = User.create username: "Razio", age: 19, email: "raz@gjeffgolden.com", password: "password"
@jeff = User.create username: "Jeff", age: 999, email: "jeff@gjeffgolden.com", password: "password"
@obinna = User.create username: "Obinna", age: 23, email: "obinna@gjeffgolden.com", password: "password"

@blackpackers = Community.create name: "Blackpackers", location: "Denver, CO", description: "A backpacking group for People of Color"
@womenintech = Community.create name: "Women in Tech", location: "New York, NY", description: "Female-led React discussions"
@board_games = Community.create name: "Board Games", location: "Seattle, WA", description: "A large community of board game players around Seattle"
@gamers = Community.create name: "LGBTQ+ Gamers", location: "Phoenix, AZ", description: "Gamers of all types welcome"
@edm = Community.create name: "EDM 4 ALL", location: "Portland, OR", description: "Good vibes only"
@dnd = Community.create name: "Inclusive DnD", location: "Philadelphia, PA", description: "DnD games open to everyone"
@concerts = Community.create name: "Concerts", location: "Los Angeles, CA", description: "A medium-sized community of concert-goers around Los Angeles"
@writers = Community.create name: "Writers of Color", location: "San Francisco, CA", description: "A writing group for POC"
@birders = Community.create name: "Latin Birders", location: "Houston, TX", description: "Discussions for birders with latin heritage"
@hiking = Community.create name: "Hiking", location: "Denver, CO", description: "A small community of hikers around Denver"
@bossladies = Community.create name: "Boss Ladies", location: "Nashville, TN", description: "A group for female managers and directors."

UserCommunity.create user: @jack, community: @hiking
UserCommunity.create user: @jack, community: @dnd
UserCommunity.create user: @jack, community: @edm
UserCommunity.create user: @ryan, community: @concerts
UserCommunity.create user: @ryan, community: @board_games
UserCommunity.create user: @raz, community: @bossladies
UserCommunity.create user: @raz, community: @womenintech
UserCommunity.create user: @raz, community: @board_games
UserCommunity.create user: @stephen, community: @writers
UserCommunity.create user: @stephen, community: @edm
UserCommunity.create user: @stephen, community: @dnd
UserCommunity.create user: @jeff, community: @hiking
UserCommunity.create user: @jeff, community: @birders
UserCommunity.create user: @obinna, community: @blackpackers
UserCommunity.create user: @obinna, community: @gamers
UserCommunity.create user: @obinna, community: @writers

CommunityOwner.create user: @jack, community: @board_games
CommunityOwner.create user: @jeff, community: @hiking
CommunityOwner.create user: @raz, community: @womenintech
CommunityOwner.create user: @obinna, community: @blackpackers
CommunityOwner.create user: @jeff, community: @gamers
CommunityOwner.create user: @jack, community: @edm
CommunityOwner.create user: @jack, community: @dnd
CommunityOwner.create user: @ryan, community: @concerts
CommunityOwner.create user: @jeff, community: @writers
CommunityOwner.create user: @jeff, community: @birders
CommunityOwner.create user: @raz, community: @bossladies

@board_game_night = Post.create user: @jack, community: @board_games, title: "Board Game Night", content: "Everybody come out this Tuesday for Board Game night at my place!", ip_address: "2651:262:1470:f170:85a6:58a4:557b:9199"
@concert_night = Post.create user: @ryan, community: @concerts, title: "Illenium Concert", content: "Illenium this Friday at Red Rocks!", ip_address: "2651:262:1470:f170:85a9:88a4:557b:9199"
@afternoon_jazzercise = Post.create user: @raz, community: @jazzercise, title: "Get Moving!", content: "Lets get MOOving this afternoon!", ip_address: "3821:262:1470:f170:85a9:88a4:557b:9934"
@weekend_hike = Post.create user: @jeff, community: @hiking, title: "CCT", content: "We're doing the CCT this weekend, everyone make sure to pack a bottle of water!", ip_address: "3321:242:1370:f110:83a9:88a4:557b:9934"
@telluride_bluegrass = Post.create user: @stephen, community: @concerts, title: "Telluride Bluegrass Festival", content: "Finally rescheduled, who's coming with???", ip_address: "9321:242:1670:f110:93a9:88a4:757b:2934"

Comment.create user: @raz, post: @board_game_night, content: "Sounds great!"
Comment.create user: @ryan, post: @board_game_night, content: "I can't make it :("
Comment.create user: @jack, post: @concert_night, content: "So cool!!!"
Comment.create user: @jeff, post: @afternoon_jazzercise, content: "Time to get my lazy butt in gear!"
Comment.create user: @ryan, post: @afternoon_jazzercise, content: "Better believe I'll be there!"
Comment.create user: @obinna, post: @afternoon_jazzercise, content: "Can't wait!"
Comment.create user: @stephen, post: @weekend_hike, content: "We could probably do it in a day..."
Comment.create user: @ryan, post: @weekend_hike, content: "Pumped!"
Comment.create user: @jack, post: @telluride_bluegrass, content: "I can't contain my excitement."
Comment.create user: @raz, post: @telluride_bluegrass, content: "HYFR"

PostLike.create post: @board_game_night, user: @obinna
PostLike.create post: @board_game_night, user: @ryan
PostLike.create post: @concert_night, user: @jeff
PostLike.create post: @concert_night, user: @jack
PostLike.create post: @afternoon_jazzercise, user: @jack
PostLike.create post: @afternoon_jazzercise, user: @jeff
PostLike.create post: @afternoon_jazzercise, user: @obinna
PostLike.create post: @afternoon_jazzercise, user: @ryan
PostLike.create post: @weekend_hike, user: @jeff
PostLike.create post: @weekend_hike, user: @stephen
PostLike.create post: @weekend_hike, user: @jack
PostLike.create post: @weekend_hike, user: @raz
PostLike.create post: @telluride_bluegrass, user: @obinna
PostLike.create post: @telluride_bluegrass, user: @jack
PostLike.create post: @telluride_bluegrass, user: @raz

PostTag.create post: @board_game_night, tag_name: "#games"
PostTag.create post: @board_game_night, tag_name: "#zombicide"
PostTag.create post: @concert_night, tag_name: "#partyUP"
PostTag.create post: @concert_night, tag_name: "#RedRocks"
PostTag.create post: @afternoon_jazzercise, tag_name: "#SpartanRacePrep"
PostTag.create post: @afternoon_jazzercise, tag_name: "#TheCoreYouCantContain"
PostTag.create post: @afternoon_jazzercise, tag_name: "#MooveItMooveIt"
PostTag.create post: @weekend_hike, tag_name: "#SummerBod"
PostTag.create post: @weekend_hike, tag_name: "#AllDownhillFromHere"
PostTag.create post: @weekend_hike, tag_name: "#NoPainNoGain"
PostTag.create post: @telluride_bluegrass, tag_name: "#GetDown"
PostTag.create post: @telluride_bluegrass, tag_name: "#Celebrate"