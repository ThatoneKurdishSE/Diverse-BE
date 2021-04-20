UserCommunity.destroy_all
User.destroy_all
Community.destroy_all

@jack = User.create username: "Jack", age: 27, email: "jack@gjeffgolden.com", password: "password"
@ryan = User.create username: "Ryan", age: 73, email: "ryan@gjeffgolden.com", password: "password"
@stephen = User.create username: "Stephen", age: 197, email: "stephen@gjeffgolden.com", password: "password"
@raz = User.create username: "Razio", age: 19, email: "raz@gjeffgolden.com", password: "password"
@jeff = User.create username: "Jeff", age: 999, email: "jeff@gjeffgolden.com", password: "password"
@obinna = User.create username: "Obinna", age: 23, email: "obinna@gjeffgolden.com", password: "password"

@hiking = Community.create name: "Hiking", location: "Denver, CO", description: "A small community of hikers around Denver"
@concerts = Community.create name: "Concerts", location: "Los Angeles, CA", description: "A medium-sized community of concert-goers around Los Angeles"
@board_games = Community.create name: "Board Games", location: "Seattle, WA", description: "A large community of board game players around Seattle"
@jazzercise = Community.create name: "Jazzercise", location: "Portland, OR", description: "A medium-sized community of jazzercise around Portland"

UserCommunity.create user: @jack, community: @hiking
UserCommunity.create user: @jack, community: @board_games
UserCommunity.create user: @jack, community: @concerts
UserCommunity.create user: @ryan, community: @concerts
UserCommunity.create user: @ryan, community: @board_games
UserCommunity.create user: @raz, community: @hiking
UserCommunity.create user: @raz, community: @jazzercise
UserCommunity.create user: @raz, community: @board_games
UserCommunity.create user: @stephen, community: @hiking
UserCommunity.create user: @stephen, community: @concerts
UserCommunity.create user: @stephen, community: @board_games
UserCommunity.create user: @jeff, community: @hiking
UserCommunity.create user: @jeff, community: @concerts
UserCommunity.create user: @obinna, community: @board_games
UserCommunity.create user: @obinna, community: @concerts
UserCommunity.create user: @obinna, community: @jazzercise