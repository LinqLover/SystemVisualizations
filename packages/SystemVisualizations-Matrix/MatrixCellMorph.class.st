Class {
	#name : #MatrixCellMorph,
	#superclass : #Morph,
	#instVars : [
		'row',
		'column',
		'labelMorph',
		'contentsMorph',
		'contents',
		'progress'
	],
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'ct 9/5/2022 17:47'
}
MatrixCellMorph class >> row: row column: column [

	^ self new
		row: row;
		column: column;
		yourself
]

{
	#category : #contents,
	#'squeak_changestamp' : 'ct 9/5/2022 17:56'
}
MatrixCellMorph >> addContent: content [

	contents addLast: content.
	self updateContents.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 17:43'
}
MatrixCellMorph >> column [

	^ column
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 17:45'
}
MatrixCellMorph >> column: anInteger [

	column := anInteger.
	
	self updateIndex.
]

{
	#category : #contents,
	#'squeak_changestamp' : 'ct 9/5/2022 18:47'
}
MatrixCellMorph >> contents [

	^ contents
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'ct 9/5/2022 19:05'
}
MatrixCellMorph >> initialize [

	super initialize.
	
	self
		borderWidth: 1 px;
		progress: 0.
	
	contents := OrderedCollection new.
	
	self
		changeTableLayout;
		listDirection: #topToBottom;
		layoutInset: 3 px;
		cellGap: 0 px;
		addMorphBack: (labelMorph := '' asMorph
			emphasis: 1;
			hResizing: #spaceFill;
			vResizing: #shrinkWrap;
			yourself);
		addMorphBack: (contentsMorph := '' asTextMorph
			hResizing: #spaceFill;
			vResizing: #shrinkWrap;
			font: TextStyle defaultFont smaller;
			wrapFlag: true;
			lock;
			yourself).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:46'
}
MatrixCellMorph >> progress [

	^ progress
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:49'
}
MatrixCellMorph >> progress: aNumber [

	progress := aNumber.
	
	self
		color: (Color white alpha: 1 - (aNumber / 2));
		borderColor: (Color black alpha: 1 - (aNumber / 2)).
]

{
	#category : #contents,
	#'squeak_changestamp' : 'ct 9/5/2022 18:48'
}
MatrixCellMorph >> resetContents [

	contents removeAll.
	self updateContents.
	self progress: 0.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 17:44'
}
MatrixCellMorph >> row [

	^ row
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 17:45'
}
MatrixCellMorph >> row: anInteger [

	row := anInteger.
	
	self updateIndex.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'ct 9/5/2022 17:56'
}
MatrixCellMorph >> updateContents [

	contentsMorph contents: contents asCommaString.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'ct 9/5/2022 17:48'
}
MatrixCellMorph >> updateIndex [

	| label |
	label := '{1}@{2}' format: {self column. self row}.
	self name: label.
	labelMorph contents: label.
]
