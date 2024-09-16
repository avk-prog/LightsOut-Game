Class {
	#name : #LOGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells'
	],
	#classVars : [
		'TheGame'
	],
	#category : #'PBE-LightsOut'
}

{ #category : #releasing }
LOGame class >> close [

	TheGame ifNotNil: [ 
		TheGame delete.
		TheGame := nil ]
]

{ #category : #'world menu' }
LOGame class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #LightsOut)
		order: 5.0;
		withSeparatorAfter;
		with: [ 
			(aBuilder item: #Run)
				order: 0;
				action: [ self open ].
			(aBuilder item: #Quit)
				order: 1;
				action: [ self close ] ]
]

{ #category : #'instance creation' }
LOGame class >> open [

	TheGame ifNil: [ 
		TheGame := self new.
		TheGame openInHand ]
]

{ #category : #accessing }
LOGame >> cellsPerSide [

	"The number of cells along each side of the game"

	^ 10
]

{ #category : #initialization }
LOGame >> defaultBorderColor [
	"answer the default border color for the game board"

	^ Color blue
]

{ #category : #initialization }
LOGame >> defaultBorderWidth [
	"answer the default border width for the game board"

	^ 3
]

{ #category : #initialization }
LOGame >> initialize [
	| sampleCell width height n |
	super initialize.
	n := self cellsPerSide.
	sampleCell := LOCell new.
	width := sampleCell width.
	height := sampleCell height.
	self bounds: (5 @ 5 extent: (width * n) @ (height * n) + (2 * self borderWidth)).
	cells := Array2D new: n tabulate: [ :i :j | self newCellAt: i at: j ]
]

{ #category : #initialization }
LOGame >> newCellAt: i at: j [

	"Create a cell for position (i,j) and add it to my on-screen
representation at the appropriate screen position.
Answer the new cell"

	| c origin |
	c := LOCell new.
	origin := self innerBounds origin.
	self addMorph: c.
	c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin.
	c mouseAction: [ self toggleNeighboursOfCellAt: i at: j ].
	^ c
]

{ #category : #'game logic' }
LOGame >> toggleNeighboursOfCellAt: i at: j [

	i > 1 ifTrue: [ (cells at: i - 1 at: j) toggleState ].
	i < self cellsPerSide ifTrue: [ (cells at: i + 1 at: j) toggleState ].
	j > 1 ifTrue: [ (cells at: i at: j - 1) toggleState ].
	j < self cellsPerSide ifTrue: [ (cells at: i at: j + 1) toggleState ]
]
