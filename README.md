Specification
=============

Hi-Q is a peg-based solitaire game played on a grid in the shape of a cross. The initial game state of the English version of the game is:

    . . .
    . . .
. . . . . . .
. . . o . . .
. . . . . . .
    . . .
    . . .

where . indicates a peg and o indicates an empty hole.

As the game progresses, pegs are removed by having one peg jump over another, horizontally or vertically, to a hole. The peg that was "jumped over" is removed from the board. The goal is to leave the game board with exactly one peg in the center, having removed all the other pegs.

Your program should generate a graphical game board and then allow the human player to make moves with the mouse. Each move involves dragging from a position containing a peg to a hole the peg can legally jump to. Each move involves clicking on a position containing a peg and then clicking on a hole the peg can legally jump to. If the move is valid, the board should be updated; otherwise the move should be ignored.

The game board should indicate the number of pegs remaining. An indication should be given when no more moves are possible.
