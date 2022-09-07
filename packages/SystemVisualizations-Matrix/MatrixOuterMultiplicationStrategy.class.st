Class {
	#name : #MatrixOuterMultiplicationStrategy,
	#superclass : #MatrixNaiveMultiplicationStrategy,
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 17:37'
}
MatrixOuterMultiplicationStrategy >> advance [

	stateIndex := stateIndex + 1.
	
	self column < self columns ifTrue:
		[^ self column: self column + 1].
	self row < self rows ifTrue:
		[self row: self row + 1.
		^ self column: 1].
	self index < self length ifTrue:
		[self row: 1.
		self column: 1.
		^ self index: self index + 1].
	^ self terminate
]
