Class {
	#name : #MatrixBlockMultiplicationStrategy,
	#superclass : #MatrixMultiplicationStrategy,
	#instVars : [
		'outerRow',
		'outerColumn',
		'innerColumn',
		'innerRow',
		'outerIndex',
		'innerIndex',
		'blockSize'
	],
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 17:21'
}
MatrixBlockMultiplicationStrategy >> advance [

	super advance.
	
	(self innerColumn < self blockWidth and: [self column < self columns]) ifTrue:
		[^ self innerColumn: self innerColumn + 1].
	(self innerRow < self blockHeight and: [self row < self rows]) ifTrue:
		[self innerColumn: 1.
		^ self innerRow: self innerRow + 1].
	(self innerIndex < self blockSize and: [self index < self length]) ifTrue:
		[self innerColumn: 1; innerRow: 1.
		^ self innerIndex: self innerIndex + 1].
	
	self outerColumn < self outerColumns ifTrue:
		[self innerColumn: 1; innerRow: 1; innerIndex: 1.
		^ self outerColumn: self outerColumn + 1].
	self outerRow < self outerRows ifTrue:
		[self innerColumn: 1; innerRow: 1; innerIndex: 1.
		self outerRow: self outerRow + 1.
		^ self outerColumn: 1].
	self outerIndex < self outerIndices ifTrue:
		[self innerColumn: 1; innerRow: 1; innerIndex: 1.
		self outerRow: 1; outerColumn: 1.
		^ self outerIndex: self outerIndex + 1].
	
	^ self terminate
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:36'
}
MatrixBlockMultiplicationStrategy >> blockHeight [

	^ self blockSize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 19:00'
}
MatrixBlockMultiplicationStrategy >> blockSize [

	^ blockSize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 19:03'
}
MatrixBlockMultiplicationStrategy >> blockSize: anInteger [

	blockSize := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:36'
}
MatrixBlockMultiplicationStrategy >> blockWidth [

	^ self blockSize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:03'
}
MatrixBlockMultiplicationStrategy >> column [

	^ self outerColumn -  1 * self blockWidth + self innerColumn
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 19:00'
}
MatrixBlockMultiplicationStrategy >> defaultBlockSize [

	^ 4
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:43'
}
MatrixBlockMultiplicationStrategy >> index [

	^ self outerIndex - 1 * self blockSize + self innerIndex
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 19:00'
}
MatrixBlockMultiplicationStrategy >> initialize [

	super initialize.
	
	blockSize := self defaultBlockSize.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:02'
}
MatrixBlockMultiplicationStrategy >> innerColumn [

	^ innerColumn
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:02'
}
MatrixBlockMultiplicationStrategy >> innerColumn: anInteger [

	innerColumn := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:09'
}
MatrixBlockMultiplicationStrategy >> innerIndex [

	^ innerIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:09'
}
MatrixBlockMultiplicationStrategy >> innerIndex: aNumber [

	innerIndex := aNumber.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:02'
}
MatrixBlockMultiplicationStrategy >> innerRow [

	^ innerRow
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:02'
}
MatrixBlockMultiplicationStrategy >> innerRow: anInteger [

	innerRow := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:03'
}
MatrixBlockMultiplicationStrategy >> outerColumn [

	^ outerColumn
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:03'
}
MatrixBlockMultiplicationStrategy >> outerColumn: anInteger [

	outerColumn := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:47'
}
MatrixBlockMultiplicationStrategy >> outerColumns [

	^ (self columns / self blockWidth) ceiling
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:09'
}
MatrixBlockMultiplicationStrategy >> outerIndex [

	^ outerIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:09'
}
MatrixBlockMultiplicationStrategy >> outerIndex: aNumber [

	outerIndex := aNumber.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:47'
}
MatrixBlockMultiplicationStrategy >> outerIndices [

	^ (self length / self blockSize) ceiling
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:02'
}
MatrixBlockMultiplicationStrategy >> outerRow [

	^ outerRow
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:03'
}
MatrixBlockMultiplicationStrategy >> outerRow: anInteger [

	outerRow := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:47'
}
MatrixBlockMultiplicationStrategy >> outerRows [

	^ (self rows / self blockHeight) ceiling
]

{
	#category : #'state machine',
	#'squeak_changestamp' : 'ct 9/5/2022 18:09'
}
MatrixBlockMultiplicationStrategy >> reset [

	outerRow := 1.
	outerColumn := 1.
	outerIndex := 1.
	innerRow := 1.
	innerColumn := 1.
	innerIndex := 1.
	
	super reset.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:04'
}
MatrixBlockMultiplicationStrategy >> row [

	^ self outerRow -  1 * self blockHeight + self innerRow
]

{
	#category : #display,
	#'squeak_changestamp' : 'ct 9/5/2022 17:55'
}
MatrixBlockMultiplicationStrategy >> updateMorph [

	super updateMorph.
	
	self terminated ifFalse:
		[self multiplicationMorph leftMatrix
			selectIndirectBlock: ((self outerIndex - 1 * self blockSize + 1 @ (self outerRow - 1 * self blockHeight + 1) extent: (self blockWidth @ self blockHeight - 1)) intersect: (1 @ 1 rect: self length @ self rows));
			"selectBlock: (self outerColumn * self blockWidth @ self row rect: self outerColumn * self blockWidth @ self row);"
			selectCell: self index @ self row.
		self multiplicationMorph topMatrix
			selectIndirectBlock: ((self outerColumn - 1 * self blockWidth + 1 @ (self outerIndex - 1 * self blockSize + 1) extent: self blockWidth @ self blockHeight - 1) intersect: (1 @ 1 rect: self columns @ self length));
			"selectBlock: (self column @ (self outerRow * self blockHeight) rect: self column @ (self outerRow + 1 * self blockHeight));"
			selectCell: self column @ self index.
		self multiplicationMorph resultMatrix
			selectIndirectBlock: ((self outerColumn - 1 * self blockWidth + 1 @ (self outerRow - 1 * self blockHeight + 1) extent: self blockWidth @ "self length"self blockHeight - 1) intersect: (1 @ 1 rect: self columns @ self rows));
			selectCell: self column @ self row].
]
