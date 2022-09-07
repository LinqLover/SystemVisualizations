Class {
	#name : #MatrixMultiplicationStrategy,
	#superclass : #Object,
	#instVars : [
		'multiplicationMorph',
		'terminated',
		'stateIndex'
	],
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'ct 9/5/2022 11:06'
}
MatrixMultiplicationStrategy class >> for: aMultiplicationMorph [

	^ self new
		multiplicationMorph: aMultiplicationMorph;
		reset;
		yourself
]

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 11:31'
}
MatrixMultiplicationStrategy >> advance [

	stateIndex := stateIndex + 1.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:01'
}
MatrixMultiplicationStrategy >> columns [

	^ self multiplicationMorph columns
]

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 18:03'
}
MatrixMultiplicationStrategy >> gotoState: index [

	self terminate; reset.
	index - 1 timesRepeat: [self advance; updateMorph].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:01'
}
MatrixMultiplicationStrategy >> length [

	^ self multiplicationMorph length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 10:58'
}
MatrixMultiplicationStrategy >> multiplicationMorph [

	^ multiplicationMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 10:58'
}
MatrixMultiplicationStrategy >> multiplicationMorph: aMultiplicationMorph [

	multiplicationMorph := aMultiplicationMorph.
]

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 11:28'
}
MatrixMultiplicationStrategy >> numberOfStates [

	^ self rows * self columns * self length
]

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 18:03'
}
MatrixMultiplicationStrategy >> reset [

	terminated := false.
	stateIndex := 0.
	self updateMorph.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:01'
}
MatrixMultiplicationStrategy >> rows [

	^ self multiplicationMorph rows
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:32'
}
MatrixMultiplicationStrategy >> stateIndex [

	^ stateIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:02'
}
MatrixMultiplicationStrategy >> terminate [

	terminated := true.
	self updateMorph.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:06'
}
MatrixMultiplicationStrategy >> terminated [

	^ terminated
]

{
	#category : #display,
	#'squeak_changestamp' : 'ct 9/5/2022 18:47'
}
MatrixMultiplicationStrategy >> updateMorph [

	self terminated
		ifTrue:
			[self multiplicationMorph leftMatrix unselectBlock; unselectIndirectBlock; unselectCell.
			self multiplicationMorph topMatrix unselectBlock; unselectIndirectBlock; unselectCell.
			self multiplicationMorph resultMatrix unselectBlock; unselectIndirectBlock; unselectCell.
			
			self multiplicationMorph resultMatrix resetAllContents]
		ifFalse:
			[| cell |
			cell := self multiplicationMorph resultMatrix cellAtRow: self row atColumn: self column.
			cell
				addContent: self index;
				progress: cell contents size / self length].
]
