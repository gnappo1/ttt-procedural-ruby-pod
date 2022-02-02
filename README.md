# Tic Tac Toe

This challenge is a collection of different methods that will help you build the entire logic for a TTT game!

## The Tic Tac Toe Board (given to you)

When building a Tic Tac Toe program, you're going to have to figure out a way to store or represent the game board. Looking at a Tic Tac Toe board, we can identify a few properties.

```
   |   |
-----------      
   |   |
-----------   
   |   |
```

A Tic Tac Toe board is basically a 3x3 grid with 9 total positions. You could think of the positions as being numbered, from top left to bottom right, as:

```
 1 | 2 | 3
-----------      
 4 | 5 | 6
-----------   
 7 | 8 | 9
```

Each cell in the Tic Tac Toe board can thus be referred to by a simple single number identifier. The middle square would be referred to as `5`.

This is super useful because it will eventually allow players to easily tell the program where they want to move. The player X could tell the program they want to move to the top left corner by saying "1". The board would represent that graphically (through ASCII) via:

```
 X |   |
-----------      
   |   |
-----------   
   |   |
```

ASCII just means using standard keyboard characters, also known as the ASCII character set, to draw graphics.

An ASCII Cat:

```
/\     /\
{  `---'  }
{  O   O  }
~~>  V  <~~
 \  \|/  /
  `-----'__
  /     \  `^\_
 {       }\ |\_\_   W
 |  \_/  |/ /  \_\_( )
  \__/  /(_O     \__/
    (  /
     ME
```

### Representing the Board as an Array

Now that we have simplified the concept of a Tic Tac Toe board to a collection of 9 positions or cells, easily identified by number, how can we represent this in code? What tool do we have at our disposal that can represent a collection of things? Is there some magical way to store data in ruby as an ordered, indexed, list? If you're thinking "We can use an Array!", you're absolutely right.

We need an array that has 9 elements. Each element in the array represents a position in the board. The first element in the array, index 0, is actually position 1 on the board, the top left corner. We'll represent the value of a position with a string that has a single space, `" "`.

## The TTT Move Method (to build)

1. Define a method to convert a user's input to an array index.
2. Define a method that updates an array passed to it.
3. Define a method with a default value.

### Overview

In this lab we'll be adding a `input_to_index` method and a `move` method to Tic Tac Toe to update the board with a player's token. The `input_to_index` method will take the user's input ("1"-"9") and convert it to the index of the board array (0-8). The `move` method represents a user moving into a position, like the middle cell, in Tic Tac Toe. We already have a method, `#display_board`, that prints out the tic tac toe board to the console and maps each location of the board to an array index. Then, we'll build a CLI that asks the player for the position on the board that they like to fill out with an "X" or an "O", convert the position to an index, update the board, and displays the updated board.

## The TTT valid_move? method (to build)

1. Define a method that returns a boolean
2. The method should check if a move is valid or not.

### Overview

In this lab we'll be adding a `valid_move?` method to make sure a move is valid before updating the board. The method will take in two arguments: the board and the position (index) where the user wants to move in. Make sure to think about what makes a move valid and use logical connectors to return a boolean in the end.

## The TTT turn method (to build)

### `#turn`

The hard part of the `#turn` method is figuring out how to handle invalid input. We know that when a user enters invalid input, we want to ask them for input again. Imagine the pseudocode again:

```
get input
convert input to index
if index is valid
  make the move for input
else
  ask for input again until you get a valid input
end
```

Asking for input again is the hard part. We either need a mechanism to repeat the entire logic again until input satisfies the valid requirement, like a loop of some sort, or we need to be able to execute a procedure that asks for a user's input again. It's almost like what we might want to do in the event of invalid user input is just replay the entire turn. No move was made, so why not just run `#turn` again?

Calling a method from within itself is totally okay in programming. In fact, it is an elegant solution to some complex problems. **Recursion** is the repeated application of the same procedure. [Google it!](https://www.google.com/search?q=recursion&oq=recursion&aqs=chrome..69i57j69i60l3j69i65l2.1630j0j1&sourceid=chrome&es_sm=119&ie=UTF-8) There's an easter egg from Google developers on that page; can you find it?

As you are already familiar with loops, that is a totally acceptable solution to the input validation problem as well.

As you try to get it working, keep playing with `bin/turn` until it works as expected, endlessly asking you for a valid turn input. If you ever need to exit the CLI without giving an input, just hit `CTRL+C` (sometimes `ALT+C` or `COMMAND+C`).

The tests will pass once you have your CLI working right, but don't be scared of running the tests to see the failures for `#turn` and seeing if they point you in the right direction.

## The TTT won?, full?, draw?, over?, winner? methods

### 1. Define WIN_COMBINATIONS

The first method to build is `#won?`. In order for that method to function, it
will have to know about all the possible winning combinations of Tic Tac Toe.

Tic Tac Toe has 8 possible ways to win: 3 horizontal rows, 3 vertical columns,
and 2 diagonals. The game board is represented by an array,
`board = [" ", " ", " ", " ", " ", " ", " ", " ", " ",]`, with 9 positions,
indexed from 0-8. You could represent the coordinates of a win condition by
referring to their index in the `board`. For example a win in the top horizontal
row:

```
 X | X | X
-----------
   |   |
-----------
   |   |
```

You could represent that as the indexes of the board `[0,1,2]`.

```ruby
# Board with winning X in the top row.
board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]

# Definition of indexes that compose a top row win.
top_row_win = [0,1,2]

# Check if each index in the top_row_win array contains an "X"
if board[top_row_win[0]] == "X" && board[top_row_win[1]] == "X" && board[top_row_win[2]] == "X"
  "X won in the top row"
end
```

Each win combination could be represented as a 3 element array referring to the
indexes in the board that create a win possibility.

Create a nested array of win combinations defined in a constant
`WIN_COMBINATIONS` within `lib/game_status.rb`. It's structure should resemble:

```ruby
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5]  # Middle row
  # ETC, an array for each win combination
]
```

Run the tests with `learn` until your `WIN_COMBINATIONS` contains all the possible solutions.

#### What's a CONSTANT

A Constant is a variable type in Ruby that has a larger scope than our local variables, namely, methods can read values from constants defined outside the method. Constants are a variable type for data that is unlikely to change. You can define a constant by starting the variable definition with a capital letter.

### `#won?`

Now that we have a constant that defines the possible win combinations
(`WIN_COMBINATIONS`), we can build a method that can check a tic tac toe board
and return true if there is a win and false if not.

Your `#won?` method should accept a board as an argument and return false/nil if
there is no win combination present in the board and return the winning
combination indexes as an array if there is a win. To clarify: this method
should **not** return _who_ won (aka X or O), but rather _how_ they won -- by
means of the winning combination.

Iterate over the possible win combinations defined in `WIN_COMBINATIONS` and
check if the board has the same player token in each index of a winning
combination. The pseudocode might look like:

```ruby
for each win_combination in WIN_COMBINATIONS
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination # return the win_combination indexes that won.
  else
    false
  end
end
```

That is a very verbose and explicit example of how you might iterate over a
nested array of `WIN_COMBINATIONS` and check each win combination index against
the value of the board at that position.

For example, on a board that has a winning combination in the top row, `#won?`
should return `[0,1,2]`, the indexes in the board that created the win:

```ruby
# Board with winning X in the top row.
board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]

won?(board) #=> [0,1,2]
```

A board with a diagonal win would function as follows:

```ruby
# Board with winning X in the right diagonal.
board = ["X", "O", "X", "O", "X", "O", "X", "X", "O"]
#  X | O | X
# -----------
#  O | X | O
# -----------
#  X | X | O

won?(board) #=> [2,4,6]
```

A board with no win would return false/nil:

```ruby
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
won?(board) #=> nil
```

You should be able to iterate over the combinations defined in
`WIN_COMBINATIONS` using `each` or a higher-level iterator to return the correct
board indexes that created the win.

Your method should work for both boards that win with an "X" or boards that win
with an "O". We've provided you with a helper method called `position_taken?`
that takes a board and an index as arguments and returns true or false based on
whether that position on the board has been filled.

```ruby
board = ["X", "X", "X", "O", " ", "O", " ", " ", " "]
#  X | X | X
# -----------
#  O |   | O
# -----------
#    |   |  

position_taken?(board, 2) #=> true
position_taken?(board, 7) #=> false
```

Read the specs in `spec/game_status_spec.rb` starting on LOC 19, the `describe "#won?"` block.

### `#full?`

The `#full?` method should accept a board and return true if every element in
the board contains either an "X" or an "O". For example:

```ruby
full_board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
full?(full_board) #=> true

incomplete_board = ["X", " ", "X", "O", " ", "X", "O", " ", "O"]
full?(incomplete_board) #=> false
```

The `#full?` method doesn't need to worry about draws or winning combinations,
simply return false if there is an available position and true if there is not.

There is a great high-level iterator besides `#each` that will make your code
super awesome elegant. But `#each` will certainly work great too.

### `#draw?`

Build a method `#draw?` that accepts a board and returns true if the board has
not been won but is full, false if the board is not won and the board is not
full, and false if the board is won. You should be able to compose this method
solely using the methods you used above with some ruby logic.

You can imagine its behavior:

```ruby
  draw_board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  draw?(draw_board) #=> true

  x_diagonal_won = ["X", "O", "X", "O", "X", "O", "O", "O", "X"]
  draw?(x_diagonal_won) #=> false

  incomplete_board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]
  draw?(incomplete_board) #=> false
```

### `#over?`

Build a method `#over?` that accepts a board and returns true if the board has
been won, is a draw, or is full. You should be able to compose this method
solely using the methods you used above with some ruby logic.

```ruby
draw_board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
over?(draw_board) #=> true

won_board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
over?(won_board) #=> true

inprogress_board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
over?(inprogress_board) #=> false
```

### `#winner`

The `#winner` method should accept a board and return the token, "X" or "O" that
has won the game given a winning board.

The `#winner` method can be greatly simplified by using the methods and their
return values you defined above.

```ruby
x_win_diagonal = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
winner(x_win_diagonal) #=> "X"

o_win_center_column = ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
winner(o_win_center_column) #=> "O"

no_winner_board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
winner(no_winner_board) #=> nil
```

## The TTT play method

The `#play` Method

You must build a `#play` method in `lib/play.rb`. (You can add it anywhere but at the bottom would be nice.)

The `#play` method should:

* Accept an argument of a `board`.
* Start a loop and call `#turn`.

A few things to think about:

* What constitutes a rousing game of Tic Tac Toe? Do the two players simply keep filling out squares forever and ever? Definitely not. Eventually the game must end. In fact, there are only 9 spots on a Tic Tac Toe board, so there is a maximum of 9 turns to be played. Account for this in the loop(s) that your `#play` method contains.
* Which looping construct (`while`, `until`, etc) you use doesn't really matter. What does matter is how and when you terminate the loop. You don't want to get stuck in an infinite loop when you execute your `bin/play` file or when you run the tests through `learn` or `rspec`. You'll notice you're in an infinite loop if you run the test or `bin` file and it "hangs," never terminating. If you do get stuck, just type `CTRL+C` to terminate the process.

As you code and try to get the tests to pass, play with your CLI and make sure that it is looping, allowing you to play multiple turns of Tic Tac Toe even if they are unrealistic according to the rules of the game. (We'll move on to working out who wins the game in a later exercise.)

A working `#play` method will produce a CLI that behaves as follows:

```
$ ./bin/play
Welcome to Tic Tac Toe!
   |   |   
-----------
   |   |   
-----------
   |   |   
Please enter 1-9:
1
 X |   |   
-----------
   |   |   
-----------
   |   |   
Please enter 1-9:
1
Please enter 1-9:
2
 X | X |   
-----------
   |   |   
-----------
   |   |    
Please enter 1-9:
3
 X | X | X
-----------
   |   |   
-----------
   |   |   
```

Remember that when you see a number in this sample output it represents user input. In this game, the first move was to position "1", the second move attempted to also move to position "1" but was denied because of validation. After the validation failure, the user entered "2", the board marked an "X" instead of an "O" in position "2", and the move was completed. The user then entered a "3" and the board was further updated. Subsequent turns would continue in a similar fashion until the enclosing loop(s) terminated.

**Note:** *Don't* just call the `#turn` method 9 times inside the `#play` method. Use the looping constructs we've learned in previous lessons!

## TTT the current_player and turn_count methods

So far, we have built a tic tac toe game that only places `"X"`'s on the board. I don't know about you, but I am not interested in playing that game. We need our game to know whose turn it is and place an `"X"` or an `"O"` on the board accordingly.

Let's break this down into the smallest possible units of work. We'll write two separate methods, a method that will tell us how many turns have been played and a method that will return, based on that information, an `"X"` if it is player `"X"`'s turn, and an `"O"` if it is player `"O"`'s turn.

Why build two separate methods? Let's talk about the Single Responsibility Principle. That principle states that methods should have *one job* and their behavior should be narrowly aligned with that job. The job of determining how many turns have been played is separate from the job of reporting whose turn it currently is, `"X"` or `"O"`, although the second job will rely on the first.

But why follow this principle? Let's think about it. Can we envision a scenario in which we might want to know how many turns have been played, without caring whether it is `"X"`'s turn next or `"O"`'s? What about when we need to determine if there is a tie? What if we want to build a game that keeps track of the user's victories and lets them know how fast their average win is? Breaking down the behavior of our program into its smallest possible constituents gives us the flexibility we need to take those building blocks and arrange them into new configurations as new goals and problems arrive.

### Instructions

You'll be building two methods `#turn_count` and `#current_player`.

### `#turn_count`

This method takes in an argument of the board array and returns the number of turns that have been played. A few things to think about:

* How will we determine whose turn it is? Let's make this easy for ourselves, and say that the player that goes first will be assigned the `"X"` token. So, if there is only one occupied space on the board, that means that player `"X"` made their move and it is now player `"O"`'s turn. If there are two occupied spaces on the board, that means that player `"O"` has just made their move and it is now player `"X"`'s turn, and so on.
* Try to implement an iterator, like `#each`, to loop over the elements of the board array. Remember that the return value of `#each` is the original array on which you are calling that method. Keep in mind the desired return value of the `#turn_count` method is the number of turns that have been played.
* We will need to keep track of the number of turns by setting some sort of counter and starting it at `0`. We will need to iterate over each member of the board array, check to see if that element is an `"X"` or an `"O"`. If it is, we increment our `counter` variable by 1.

#### A Refresher Note on Incrementation: The `+=` Operator

Let's say we have a variable called `counter` that we want to increment (increase by one) every time a certain condition is met.

We could do it like this:

```ruby
counter = 0
if my_condition_is_met
  counter = counter + 1
end
```
This re-sets the `counter` variable equal to the value of the *original* or previous `counter` variable value + 1.

To clean this up, or refactor it, a bit, we can use the `+=` or "plus-equals" operator:

```ruby
counter = 0
if my_condition_is_met
  counter += 1
end
```

The line, `counter += 1` is exactly the same as saying `counter = counter + 1`. The plus-equals operator sets a variable equal to it's previous value plus whatever number is on the right hand side of the operator.

### `#current_player`

The `#current_player` method should take in an argument of the game board and use the `#turn_count` method to determine if it is `"X"`'s turn or `"O"`'s.

If the turn count is an even number, the `#current_player` method should return `"X"`, otherwise, it should return `"O"`.

#### Determining If a Number is Even or Odd

What makes a number even? If it is evenly divisible by 2––if dividing that number by 2 leaves a remainder of 0. There is a Ruby method for determining the remainder of one number, divided by another, the `%`, or modulo, operator.

Here's how it works:

```ruby
4 % 2 #=> 0

15 % 2 #=> 1
```

Try using the `%` operator in your `#current_player` method. Then, try refactoring your method to use the `.even?` or `.odd?` methods. Look them up in the Ruby Docs to learn more.