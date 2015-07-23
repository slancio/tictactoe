# TicTacToe

A CLI-based TicTacToe game that allows Human and Unbeatable AI players.

# How to use:
* To play vs the computer, as X (Human) & O (Computer), run ```ruby lib/game.rb```
* Otherwise, ```require lib/game.rb``` in your project and use the classes provided.
* Create Human players with ```HumanPlayer.new("<player_name>")```
* Create Computer players with ```ComputerPlayer.new```
* By default, TicTacToe.new will create a new game with an X (Human) and O (Computer) player.
* Run the game with the game instance's ```play``` method.
* You can specify players and even their marks and the turn order.
* If you do not specify the turn order, it will order players in the order they're passed.

Examples:

TicTacToe.new.play

    steve = HumanPlayer.new("Steve")
    ai = ComputerPlayer.new

    TicTacToe.new({players: { x: ai, o: steve }}).play

    game = TicTacToe.new({players: { t: steve, p: ai }, turn_order: [:p, :t]})
    game.play
