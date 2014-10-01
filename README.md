Specification
=============

[HI-Q](http://en.wikipedia.org/wiki/Peg_solitaire) is a peg-based solitaire game played on a grid in the shape of a cross. The initial game state of the English version of the game is shown [here] (http://en.wikipedia.org/wiki/Peg_solitaire#Board). The . indicates a peg and o indicates an empty hole.

As the game progresses, pegs are removed by having one peg jump over another, horizontally or vertically, to a hole. The peg that was "jumped over" is removed from the board. The goal is to leave the game board with exactly one peg in the center, having removed all the other pegs.

Your program should generate a graphical game board and then allow the human player to make moves with the mouse. Each move involves dragging from a position containing a peg to a hole the peg can legally jump to. Each move involves clicking on a position containing a peg and then clicking on a hole the peg can legally jump to. If the move is valid, the board should be updated; otherwise the move should be ignored.

The game board should indicate the number of pegs remaining. An indication should be given when no more moves are possible.

Installation
=============
Download the squeak environment [here] (http://www.squeak.org/Downloads). Once the environment is installed create a new Morphic Project (Projects->New Project->New MorphicProject). Once you have created a project left click anywhere on the screen and select "open" and then "file list" from the menu. This will bring up another window that you can use to import the smalltalk file in the repository. Once you find the file, right click and select "fileIn entire file" from the menu.

The game code is now imported into your squeak enviroment! Now we will run the game. Open a workspace (Tools->Workspace) and type in the following command:

<code>HiQGame new openInWorld</code>

Then hit ctrl+d to execute the command.

If everything went according to plan, a game board will be generated on the screen.

How to Play
=============
The goal of the game is to jump over pegs until there is 1 remaining on the board. You can find a detailed set of rules with a few example moves [here] (http://en.wikipedia.org/wiki/Peg_solitaire#Play).

The peg colours on the game board correspond to the following states:

 - Red - Active/Clicked
 - Black - Normal Peg
 - White - Empty Peg Slot

Technical Notes
=============
The program is broken up into the following classes:

- HiQCell - This class handles the cell/peg drawing, peg colour, and peg state
- HiQGame - This class handles all of the game logic and utilizes the HiQCell class and HiQScoreboard class
- HiQScoreboard - This class draws and updates the HiQScoreboard

The <code>gameLogic()</code> function in the HiQGame class is the core of the game as it handles everything when a peg is clicked.

Test Cases
=============
All four valid jumps (left, right, up, down)
Lose the game (run out of moves)
Several invalid jumps:
  - jump to a position with a peg
  - jump to a position off the board
  - make a jump that doesn't satisfy the <code>isValidMove()</code> function





