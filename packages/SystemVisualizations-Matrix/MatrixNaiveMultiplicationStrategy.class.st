Class {
	#name : #MatrixNaiveMultiplicationStrategy,
	#superclass : #MatrixMultiplicationStrategy,
	#instVars : [
		'row',
		'column',
		'index'
	],
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 11:31'
}
MatrixNaiveMultiplicationStrategy >> advance [

	super advance.
	
	self index < self length ifTrue:
		[^ self index: self index + 1].
	self column < self columns ifTrue:
		[self column: self column + 1.
		^ self index: 1].
	self row < self rows ifTrue:
		[self row: self row + 1.
		self column: 1.
		^ self index: 1].
	^ self terminate
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:00'
}
MatrixNaiveMultiplicationStrategy >> column [

	^ column
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:00'
}
MatrixNaiveMultiplicationStrategy >> column: anInteger [

	column := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:09'
}
MatrixNaiveMultiplicationStrategy >> index [

	^ index
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:10'
}
MatrixNaiveMultiplicationStrategy >> index: aNumber [

	index := aNumber.
]

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 18:07'
}
MatrixNaiveMultiplicationStrategy >> reset [

	row := 1.
	column := 1.
	index := 1.
	
	super reset.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:02'
}
MatrixNaiveMultiplicationStrategy >> row [

	^ row
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:00'
}
MatrixNaiveMultiplicationStrategy >> row: anInteger [

	row := anInteger.
]

{
	#category : #display,
	#'squeak_changestamp' : 'ct 9/5/2022 17:55'
}
MatrixNaiveMultiplicationStrategy >> updateMorph [

	super updateMorph.
	
	self terminated ifFalse:
		[self multiplicationMorph leftMatrix
			selectIndirectColumn: self index;
			selectRow: self row;
			selectCell: self index @ self row.
		self multiplicationMorph topMatrix
			selectIndirectRow: self index;
			selectColumn: self column;
			selectCell: self column @ self index.
		self multiplicationMorph resultMatrix selectCell: self column @ self row].
]
