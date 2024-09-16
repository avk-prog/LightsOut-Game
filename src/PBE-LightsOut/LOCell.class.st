Class {
	#name : #LOCell,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'mouseAction'
	],
	#category : #'PBE-LightsOut'
}

{ #category : #initialization }
LOCell >> initialize [
	super initialize.
	self label: ''.
	self borderWidth: 2.
	bounds := 0 @ 0 corner: 16 @ 16.
	offColor := Color yellow.
	onColor := Color r:0 g:0.4 b:1.
	self useSquareCorners.
	self turnOff
]

{ #category : #accessing }
LOCell >> mouseAction: aBlock [

	mouseAction := aBlock
]

{ #category : #'event handling' }
LOCell >> mouseMove: event [
	"Do nothing"
]

{ #category : #'event handling' }
LOCell >> mouseUp: anEvent [

	mouseAction value
]
