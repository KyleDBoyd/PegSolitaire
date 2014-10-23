SimpleSwitchMorph subclass: #HiQCell
	instanceVariableNames: 'peg mouseAction activeCell'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'HiQ-Game'!
!HiQCell commentStamp: 'KB 9/21/2014 00:38' prior: 0!
"HIQ Cell Class"!
]style[(16)f1!


!HiQCell methodsFor: 'initialization' stamp: 'KB 9/30/2014 01:22'!
initialize
	super initialize.
	self label: ''.
	self borderWidth: 2.
	bounds := 0@0 corner: 50@50.
	activeCell := true.
	self useSquareCorners.
	self turnOn.! !


!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/19/2014 22:21'!
drawPeg
	peg := CircleMorph new.
	self addMorph: peg.
	peg color: Color black.
	peg height: 25.
	peg width: 25.
	peg center: self center.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/23/2014 16:42'!
getPegColor
	^ peg color.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/28/2014 12:21'!
isActiveCell
	^ activeCell.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/27/2014 00:40'!
isDeadPeg
	^ peg color = Color white.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/28/2014 12:10'!
isLivePeg
	^ peg color = Color black.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/19/2014 22:42'!
mouseAction: aBlock
	^mouseAction:= aBlock.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/21/2014 01:28'!
resetPeg
	peg color: Color black.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:29'!
setActivePeg
	peg color: Color red.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/21/2014 00:41'!
setDeadCell
	activeCell := false.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:28'!
setDeadPeg
	peg color: Color white.! !

!HiQCell methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:28'!
setLivePeg
	peg color: Color black.! !


!HiQCell methodsFor: 'event handling' stamp: 'KB 9/23/2014 16:11'!
mouseDown: anEvent
	mouseAction value! !


BorderedMorph subclass: #HiQGame
	instanceVariableNames: 'cells previousCell currentCell scoreboard pegsRemaining numValidMoves'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'HiQ-Game'!

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/16/2014 21:38'!
cellsPerSide
"The number of cells in each row and column."
	^7! !

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:34'!
"Handles the core logic of the HiQGame. Checks for valid moves and updates the scoreboard when a move is performed."
gameLogic: i at: j
	| middleCell middleCellObject currentCellObject previousCellObject|
	currentCell = nil ifFalse: [previousCell := currentCell].
	currentCell := Array new: 2.
	currentCell at: 1 put: i.
	currentCell at: 2 put: j.
	currentCellObject := cells at: (currentCell at: 1) at: (currentCell at: 2).
	previousCell ~= nil & (previousCell ~= currentCell) ifTrue: 
	[
		previousCellObject := cells at: (previousCell at: 1) at: (previousCell at: 2).
		currentCellObject isDeadPeg ifTrue: 
		[
			middleCell := self getMiddlePeg: previousCell at: currentCell.
			middleCellObject := cells at: (middleCell at: 1) at: (middleCell at: 2).
			middleCellObject isActiveCell ifTrue: 
			[
				(self isValidMove: previousCell at: currentCell at: middleCellObject) ifTrue: 
				[
					middleCellObject setDeadPeg.
					previousCellObject setDeadPeg.
                              		currentCellObject setLivePeg.
					currentCell := nil.
					previousCell := nil.
					pegsRemaining := pegsRemaining - 1.
					numValidMoves := self numValidMoves.
					scoreboard update: pegsRemaining at: numValidMoves.
				] 
				ifFalse:
				[
					currentCellObject isDeadPeg ifFalse: [currentCellObject setActivePeg.].
					previousCellObject isDeadPeg ifFalse: [previousCellObject resetPeg.].
				].
			]
			ifFalse:
			[
				currentCellObject isDeadPeg ifFalse: [currentCellObject setActivePeg.].
				previousCellObject isDeadPeg ifFalse: [previousCellObject resetPeg.].
			].
		]
		ifFalse:
		[
			currentCellObject setActivePeg.
			previousCellObject isDeadPeg ifFalse: [previousCellObject resetPeg.].
		].
	]
	ifFalse:
	[
		currentCellObject isDeadPeg ifFalse: [currentCellObject setActivePeg.].
	].
! !

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:36'!
"Returns the indexes of the peg between the previous and current pegs"
getMiddlePeg: prevPeg at: currentPeg
	| middlePeg |
	middlePeg := Array new: 2.
	(prevPeg at: 1) = (currentPeg at: 1) ifTrue: [middlePeg at: 1 put: (currentPeg at: 1)] ifFalse: [middlePeg at: 1 put: ((prevPeg at: 1) + (currentPeg at: 1) / 2)].
	(prevPeg at: 2) = (currentPeg at: 2) ifTrue: [middlePeg at: 2 put: (currentPeg at: 2)] ifFalse: [middlePeg at: 2 put: ((prevPeg at: 2) + (currentPeg at: 2) / 2)].
	^ middlePeg.
! !

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 00:33'!
getNumPegs
	^ pegsRemaining! !

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:27'!
"Checks if the move from the previous peg and current peg are valid. This function assumes that the current peg is an empty peg."
isValidMove: prevPeg at: currentPeg at: middlePegObject
	^ (middlePegObject isLivePeg & (((prevPeg at: 1) = (currentPeg at: 1) & ((((prevPeg at: 2) - (currentPeg at: 2))) abs) = 2) | (((prevPeg at: 2) = (currentPeg at: 2)) & (((prevPeg at: 1) - (currentPeg at: 1)) abs = 2)))).! !

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:29'!
newCellAt: i at: j
"Create a cell/peg for position (i,j) and add it to my on-screen
representation at the appropriate screen position. Answer the new cell"
| c origin hash |
c := HiQCell new.
hash:= #(1 2 6 7).
((hash includes: i) & (hash includes: j)) ifTrue: [c setDeadCell] ifFalse: [c drawPeg. pegsRemaining := pegsRemaining + 1].
(i = 4 & j = 4) ifTrue: [c setDeadPeg. pegsRemaining := pegsRemaining -1].
origin := self innerBounds origin.
self addMorph: c.
c position: ((i - 1)*c width) @ ((j - 1)*c height)+origin.
((hash includes: i) & (hash includes: j)) ifFalse: [c mouseAction: [self gameLogic: i at: j]].
^c! !

!HiQGame methodsFor: 'as yet unclassified' stamp: 'KB 9/30/2014 01:24'!
"Runs through the matrix of cells to find valid moves. Returns the number of possible moves."
numValidMoves
	| currentCellObject potentialMoveCellObject potentialMoveCell cellCurrent validMoves middleCell middleCellObject |
	validMoves := 0.
	1 to:  self cellsPerSide do: [:i |
		1 to: self cellsPerSide do: [:j |
			currentCellObject := cells at: i at: j.
			currentCellObject isActiveCell ifTrue:
			[
				currentCellObject isLivePeg ifTrue: 
				[
					1 to:  self cellsPerSide do: [:k |
						1 to:  self cellsPerSide do: [:l |
							potentialMoveCellObject := cells at: k at: l.
							potentialMoveCellObject isActiveCell ifTrue:
							[
								potentialMoveCellObject isDeadPeg ifTrue: 
								[
									cellCurrent := Array new: 2.
									cellCurrent at: 1 put: i.
									cellCurrent at: 2 put: j.

									potentialMoveCell := Array new: 2.
									potentialMoveCell at: 1 put: k.
									potentialMoveCell at: 2 put: l.

									middleCell := self getMiddlePeg: potentialMoveCell at: cellCurrent.
									middleCellObject := cells at: (middleCell at: 1) at: (middleCell at: 2).
									middleCellObject isActiveCell ifTrue:
		 							[
										(self isValidMove: cellCurrent at: potentialMoveCell at: middleCellObject) ifTrue: 
										[
											validMoves := validMoves + 1.
										].
									].
								].
							].
						].
					].
				].
			].
		].		
	].
	^ validMoves! !


!HiQGame methodsFor: 'initialization' stamp: 'KB 9/30/2014 01:36'!
initialize
| sampleCell width height n |
super initialize.
n := self cellsPerSide.
sampleCell := HiQCell new.
width := sampleCell width.
height := sampleCell height.
pegsRemaining := 0.
numValidMoves := -1.
self bounds: (50@150 extent: ((width*n) @(height*n))+(2*self borderWidth)).
cells := Matrix new: n tabulate: [ :i :j | self newCellAt: i at: j ].
scoreboard := HiQScoreboard new.
scoreboard initializeText: pegsRemaining.
self addMorph: scoreboard.
! !


RectangleMorph subclass: #HiQScoreboard
	instanceVariableNames: 'scoreboardText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'HiQ-Game'!

!HiQScoreboard methodsFor: 'initialization' stamp: 'KB 9/30/2014 01:21'!
initialize
| sampleCell width height n |
super initialize.
sampleCell := HiQCell new.
width := sampleCell width.
height := sampleCell height.
n := 7.
self bounds: (50@50 extent: ((width*n) +(2*self borderWidth) @ (height*2))).! !

!HiQScoreboard methodsFor: 'initialization' stamp: 'KB 9/30/2014 01:18'!
initializeText: numPegs 
	scoreboardText := TextMorph new.
	scoreboardText contents: numPegs asString , ' Pegs Remaining'.
	scoreboardText center: self center.
	scoreboardText fontName: 'Arial' size: 15.
	scoreboardText width: 300.
	self addMorph: scoreboardText! !


!HiQScoreboard methodsFor: 'updating' stamp: 'KB 9/30/2014 20:21'!
update: numPegs at: numValidMoves 
	numValidMoves = 0
		ifTrue: [numPegs = 1
				ifTrue: [scoreboardText contents: 'You Win!!']
				ifFalse: [scoreboardText contents: 'Game Over. ' , numPegs asString , ' pegs remaining.']]
		ifFalse: [scoreboardText contents: numPegs asString , ' pegs remaining.']! !
