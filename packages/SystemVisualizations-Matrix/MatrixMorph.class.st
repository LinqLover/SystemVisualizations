Class {
	#name : #MatrixMorph,
	#superclass : #Morph,
	#instVars : [
		'cells',
		'blockSelection',
		'cellSelection',
		'indirectBlockSelection'
	],
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'ct 9/5/2022 10:25'
}
MatrixMorph class >> rows: rows columns: columns [

	^ self new
		rows: rows columns: columns;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 10:40'
}
MatrixMorph >> backgroundColor [

	^ Color lightGray
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 17:53'
}
MatrixMorph >> cellAtRow: row atColumn: column [

	^ cells at: row at: column
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 10:41'
}
MatrixMorph >> color: aColor [

	^ super color: (aColor alpha: 0.5)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 10:50'
}
MatrixMorph >> columns [

	^ cells columnCount
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 12:22'
}
MatrixMorph >> initialize [

	super initialize.
	
	self changeProportionalLayout.
	
	self color: self backgroundColor.
	
	self rows: 0 columns: 0.
	blockSelection := Morph new
		color: (Color orange alpha: 0.5);
		borderWidth: 3 px;
		borderColor: Color orange;
		yourself.
	cellSelection := Morph new
		color: (Color red alpha: 0.5);
		borderWidth: 5 px;
		borderColor: Color red;
		yourself.
	indirectBlockSelection := Morph new
		color: (Color yellow alpha: 0.25);
		borderWidth: 2 px;
		borderColor: Color yellow;
		yourself.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 10:52'
}
MatrixMorph >> rect [

	^ self columns @ self rows
]

{
	#category : #contents,
	#'squeak_changestamp' : 'ct 9/5/2022 17:52'
}
MatrixMorph >> resetAllContents [

	cells do: #resetContents.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 10:50'
}
MatrixMorph >> rows [

	^ cells rowCount
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:30'
}
MatrixMorph >> rows: rows columns: columns [

	cells ifNotNil: [:cell |
		cell do: #abandon].
	cells := Matrix rows: rows columns: columns tabulate: [:row :column |
		| cell |
		cell := (MatrixCellMorph row: row column: column)
			hResizing: #spaceFill; vResizing: #spaceFill;
			layoutFrame:
				(LayoutFrame fractions:
					((column - 1 / columns) @ (row - 1 / rows) extent: (columns @ rows) reciprocal));
			yourself.
		self addMorph: cell.
		cell].
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:22'
}
MatrixMorph >> selectBlock: rect [

	^ self selectBlock: rect withMorph: blockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:21'
}
MatrixMorph >> selectBlock: rect withMorph: selectionMorph [

	self addMorph: selectionMorph fullFrame:
		(LayoutFrame fractions:
			(rect origin - 1 / self rect corner: rect corner / self rect)).
	selectionMorph show.
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:11'
}
MatrixMorph >> selectCell: aPoint [

	self addMorph: cellSelection fullFrame:
		(LayoutFrame fractions:
			(aPoint - 1 / self rect corner: aPoint / self rect)).
	blockSelection show.
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:23'
}
MatrixMorph >> selectColumn: column [

	^ self
		selectColumn: column
		withMorph: blockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:22'
}
MatrixMorph >> selectColumn: column withMorph: selectionMorph [

	^ self
		selectBlock: (column @ 1 rect: column @ self rows)
		withMorph: selectionMorph
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:22'
}
MatrixMorph >> selectIndirectBlock: rect [

	^ self selectBlock: rect withMorph: indirectBlockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:23'
}
MatrixMorph >> selectIndirectColumn: column [

	^ self
		selectColumn: column
		withMorph: indirectBlockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:23'
}
MatrixMorph >> selectIndirectRow: row [

	^ self
		selectRow: row
		withMorph: indirectBlockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:23'
}
MatrixMorph >> selectRow: row [

	^ self
		selectRow: row
		withMorph: blockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:23'
}
MatrixMorph >> selectRow: row withMorph: selectionMorph [

	^ self
		selectBlock: (1 @ row rect: self columns @ row)
		withMorph: selectionMorph
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:22'
}
MatrixMorph >> unselectBlock [

	^ self unselectBlockMorph: blockSelection
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:22'
}
MatrixMorph >> unselectBlockMorph: selectionMorph [

	selectionMorph delete.
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:11'
}
MatrixMorph >> unselectCell [

	cellSelection delete.
]

{
	#category : #selecting,
	#'squeak_changestamp' : 'ct 9/5/2022 11:22'
}
MatrixMorph >> unselectIndirectBlock [

	^ self unselectBlockMorph: indirectBlockSelection
]
